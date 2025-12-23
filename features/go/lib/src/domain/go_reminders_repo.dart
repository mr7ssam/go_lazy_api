import 'package:go/go_domain.dart';

abstract class IGoRemindersRepo {
  Future<GoReminder> createReminder(GoReminder reminder);
  Future<void> updateReminder(GoReminder reminder);
  Future<GoReminder?> getReminderById(String id);
  Future<List<GoReminder>> getTaskReminders(String taskId);
  Future<List<GoReminder>> getUserReminders(String userId);
  Future<void> deleteReminder(String id);
}
