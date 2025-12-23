import 'package:go/src/domain/entities/go_reminder_type.dart';

/// A reminder for a task
class GoReminder {
  const GoReminder({
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
  final GoReminderType reminderType;
  final DateTime? remindAt;
  final int? minutesBefore;
  final bool isSent;
  final DateTime? sentAt;
  final DateTime createdAt;

  GoReminder copyWith({
    String? id,
    String? taskId,
    String? userId,
    GoReminderType? reminderType,
    DateTime? remindAt,
    int? minutesBefore,
    bool? isSent,
    DateTime? sentAt,
    DateTime? createdAt,
  }) {
    return GoReminder(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      reminderType: reminderType ?? this.reminderType,
      remindAt: remindAt ?? this.remindAt,
      minutesBefore: minutesBefore ?? this.minutesBefore,
      isSent: isSent ?? this.isSent,
      sentAt: sentAt ?? this.sentAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
