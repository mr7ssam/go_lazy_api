class CreateReminderRequest {
  const CreateReminderRequest({
    required this.taskId,
    required this.userId,
    required this.reminderType,
    this.remindAt,
    this.minutesBefore,
  });

  factory CreateReminderRequest.fromJson(Map<String, dynamic> json) =>
      CreateReminderRequest(
        taskId: json['taskId'] as String,
        userId: json['userId'] as String,
        reminderType: json['reminderType'] as String,
        remindAt: json['remindAt'] != null
            ? DateTime.parse(json['remindAt'] as String)
            : null,
        minutesBefore: json['minutesBefore'] as int?,
      );

  final String taskId;
  final String userId;
  final String reminderType;
  final DateTime? remindAt;
  final int? minutesBefore;

  CreateReminderRequest copyWith({
    String? taskId,
    String? userId,
    String? reminderType,
    DateTime? remindAt,
    int? minutesBefore,
  }) {
    return CreateReminderRequest(
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      reminderType: reminderType ?? this.reminderType,
      remindAt: remindAt ?? this.remindAt,
      minutesBefore: minutesBefore ?? this.minutesBefore,
    );
  }
}

class CreateReminderResponse {
  const CreateReminderResponse({
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
