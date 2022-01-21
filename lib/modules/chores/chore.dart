import 'package:chore_manager_mobile/data/concerns/jsonable.dart';
import 'package:chore_manager_mobile/extensions/date_time_formatting.dart';

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
        'created_at': createdAt,
        'updated_at': updatedAt,
        'next_due_date': nextDueDate?.toDateString(),
        'due_date_updated_at': dueDateUpdatedAt,
      };
}
