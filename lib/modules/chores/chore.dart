import 'package:chore_manager_mobile/data/concerns/jsonable.dart';
import 'package:chore_manager_mobile/extensions/date_time_formatting.dart';
import 'package:intl/intl.dart';

class Chore with Jsonable {
  int id;
  int userId;
  String title;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;
  int? teamId;
  int? frequencyId;
  int? frequencyInterval;
  int? frequencyDayOf;
  int? nextDueUserId;
  DateTime? nextDueDate;
  DateTime? dueDateUpdatedAt;

  Chore({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.teamId,
    this.frequencyId,
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
        frequencyId = json['frequency_id'],
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
        'frequency_id': frequencyId,
        'frequency_interval': frequencyInterval,
        'frequency_day_of': frequencyDayOf,
        'created_at': createdAt.toFullIso8601String(),
        'updated_at': updatedAt.toFullIso8601String(),
        'next_due_user_id': nextDueUserId,
        'next_due_date': nextDueDate?.toDateString(),
        'due_date_updated_at': dueDateUpdatedAt?.toFullIso8601String(),
      };

  @override
  String toString() => toJsonString();

  String get friendlyDueDate {
    if (this.nextDueDate == null) return '-';
    final DateTime nextDueDate = this.nextDueDate!.toStartOfDay();

    final timeDiffInDays =
        nextDueDate.difference(DateTime.now().toStartOfDay()).inDays;

    if (timeDiffInDays == 0) {
      return 'today';
    } else if (timeDiffInDays == 1) {
      return 'tomorrow';
    } else if (timeDiffInDays == -1) {
      return 'yeseterday';
    } else if (timeDiffInDays < 7) {
      return DateFormat(DateFormat.WEEKDAY).format(nextDueDate);
    }

    return DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(nextDueDate);
  }

  bool get hasNoDueDate => nextDueDate != null;
}
