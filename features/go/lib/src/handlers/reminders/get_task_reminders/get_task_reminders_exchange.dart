class GetTaskRemindersRequest {
  const GetTaskRemindersRequest({
    required this.taskId,
    required this.userId,
  });

  final String taskId;
  final String userId;
}

class GetTaskRemindersResponse {
  const GetTaskRemindersResponse({
    required this.reminders,
  });

  final List<ReminderDto> reminders;

  Map<String, dynamic> toJson() => {
        'reminders': reminders.map((r) => r.toJson()).toList(),
      };
}

class ReminderDto {
  const ReminderDto({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.reminderType,
    required this.isSent,
    required this.createdAt,
    this.remindAt,
    this.minutesBefore,
    this.sentAt,
  });

  final String id;
  final String taskId;
  final String userId;
  final String reminderType;
  final DateTime? remindAt;
  final int? minutesBefore;
  final bool isSent;
  final DateTime? sentAt;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'taskId': taskId,
        'userId': userId,
        'reminderType': reminderType,
        'remindAt': remindAt?.toIso8601String(),
        'minutesBefore': minutesBefore,
        'isSent': isSent,
        'sentAt': sentAt?.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
      };
}
