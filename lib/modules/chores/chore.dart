import 'package:chore_manager_mobile/constants/strings.dart';
import 'package:chore_manager_mobile/data/concerns/jsonable.dart';
import 'package:chore_manager_mobile/extensions/date_time_formatting.dart';
import 'package:chore_manager_mobile/modules/chores/frequency.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Chore extends Equatable with Jsonable {
  final int id;
  final String title;
  final Frequency frequency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? userId;
  final String? description;
  final int? teamId;
  final int? frequencyInterval;
  final int? frequencyDayOf;
  final int? nextDueUserId;
  final DateTime? nextDueDate;
  final DateTime? dueDateUpdatedAt;

  Chore({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.frequency,
    this.description,
    this.teamId,
    this.frequencyInterval,
    this.frequencyDayOf,
    this.nextDueUserId,
    this.nextDueDate,
    this.dueDateUpdatedAt,
  });

  Chore.fromJson(json)
      : id = json['id'],
        userId = json['user_id'],
        title = json['title'],
        description = json['description'],
        teamId = json['team_id'],
        frequency = Frequency.fromId(json['frequency_id']),
        frequencyInterval = json['frequency_interval'],
        frequencyDayOf = json['frequency_day_of'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        nextDueUserId = json['next_due_user_id'],
        nextDueDate = _parseOptionalDateTime(json['next_due_date']),
        dueDateUpdatedAt = _parseOptionalDateTime(json['due_date_updated_at']);

  static DateTime? _parseOptionalDateTime(String? dt) =>
      dt != null ? DateTime.parse(dt) : null;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'description': description,
        'team_id': teamId,
        'frequency_id': frequency.id,
        'frequency_interval': frequencyInterval,
        'frequency_day_of': frequencyDayOf,
        'created_at': createdAt.toFullIso8601String(),
        'updated_at': updatedAt.toFullIso8601String(),
        'next_due_user_id': nextDueUserId,
        'next_due_date': nextDueDate?.toDateString(),
        'due_date_updated_at': dueDateUpdatedAt?.toFullIso8601String(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        createdAt,
        updatedAt,
        teamId,
        frequency,
        frequencyInterval,
        frequencyDayOf,
        nextDueUserId,
        nextDueDate,
        dueDateUpdatedAt,
      ];

  String get friendlyDueDate {
    if (this.nextDueDate == null) return '-';
    final DateTime nextDueDate = this.nextDueDate!.toStartOfDay();

    final timeDiffInDays = diffDaysRoundAwayFromZero(nextDueDate);

    if (timeDiffInDays == 0) {
      return Strings.today;
    } else if (timeDiffInDays == 1) {
      return Strings.tomorrow;
    } else if (timeDiffInDays == -1) {
      return Strings.yesterday;
    } else if (timeDiffInDays < 7) {
      return DateFormat(DateFormat.WEEKDAY).format(nextDueDate);
    }

    return DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(nextDueDate);
  }

  String get friendlyFrequency => frequency.friendlyName;

  bool get hasDueDate => nextDueDate != null;
  bool get hasNoDueDate => !hasDueDate;

  int diffDaysRoundAwayFromZero(DateTime date) {
    final diff = date.difference(DateTime.now().toStartOfDay()).inHours / 24;

    return diff > 0 ? diff.ceil() : diff.floor();
  }
}
