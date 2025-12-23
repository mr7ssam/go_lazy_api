import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';

class GoReminderInputTransformer {
  static Insertable<GoRemindersTableData> transform(GoReminder reminder) {
    return GoRemindersTableCompanion(
      id: Value(reminder.id),
      taskId: Value(reminder.taskId),
      userId: Value(reminder.userId),
      reminderType: Value(reminder.reminderType),
      remindAt: Value(reminder.remindAt),
      minutesBefore: Value(reminder.minutesBefore),
      isSent: Value(reminder.isSent),
      sentAt: Value(reminder.sentAt),
      createdAt: Value(reminder.createdAt),
    );
  }
}

class GoReminderOutputTransformer {
  static GoReminder transform(GoRemindersTableData data) {
    return GoReminder(
      id: data.id,
      taskId: data.taskId,
      userId: data.userId,
      reminderType: data.reminderType,
      remindAt: data.remindAt,
      minutesBefore: data.minutesBefore,
      isSent: data.isSent,
      sentAt: data.sentAt,
      createdAt: data.createdAt,
    );
  }
}
