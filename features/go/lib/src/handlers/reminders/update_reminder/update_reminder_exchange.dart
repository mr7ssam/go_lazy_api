class UpdateReminderRequest {
  const UpdateReminderRequest({
    required this.id,
    required this.userId,
    this.reminderType,
    this.remindAt,
    this.minutesBefore,
  });

  factory UpdateReminderRequest.fromJson(Map<String, dynamic> json) =>
      UpdateReminderRequest(
        id: json['id'] as String,
        userId: json['userId'] as String,
        reminderType: json['reminderType'] as String?,
        remindAt: json['remindAt'] != null
            ? DateTime.parse(json['remindAt'] as String)
            : null,
        minutesBefore: json['minutesBefore'] as int?,
      );

  final String id;
  final String userId;
  final String? reminderType;
  final DateTime? remindAt;
  final int? minutesBefore;
}

class UpdateReminderResponse {
  const UpdateReminderResponse({
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
