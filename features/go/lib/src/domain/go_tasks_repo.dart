import 'package:go/go_domain.dart';

abstract class IGoTasksRepo {
  Future<GoTask> createTask(GoTask task);
  Future<void> updateTask(GoTask task);
  Future<GoTask?> getTaskById(String id);
  Future<List<GoTask>> getEventTasks(String eventId);
  Future<List<GoTask>> getUserTasks(String userId);
  Future<void> markTaskDone(String taskId);
  Future<void> deleteTask(String id);
}
