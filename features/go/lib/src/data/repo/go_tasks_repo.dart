import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';

class GoTasksRepo implements IGoTasksRepo {
  GoTasksRepo({required GoDao goDao}) : _goDao = goDao;

  final GoDao _goDao;

  @override
  Future<GoTask> createTask(GoTask task) async {
    final companion = GoTaskInputTransformer.transform(task);
    final result =
        await _goDao.into(_goDao.goTasksTable).insertReturning(companion);

    return GoTaskOutputTransformer.transform(result);
  }

  @override
  Future<void> updateTask(GoTask task) async {
    final companion = GoTaskInputTransformer.transform(task);

    await (_goDao.update(_goDao.goTasksTable)
          ..where((tbl) => tbl.id.equals(task.id)))
        .write(companion);
  }

  @override
  Future<GoTask?> getTaskById(String id) async {
    final query = _goDao.select(_goDao.goTasksTable)
      ..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();

    return result != null ? GoTaskOutputTransformer.transform(result) : null;
  }

  @override
  Future<List<GoTask>> getEventTasks(String eventId) async {
    final query = _goDao.select(_goDao.goTasksTable)
      ..where(
        (tbl) => tbl.eventId.equals(eventId),
      );

    final results = await query.get();

    return results.map(GoTaskOutputTransformer.transform).toList();
  }

  @override
  Future<List<GoTask>> getUserTasks(String userId) async {
    final query = _goDao.select(_goDao.goTasksTable)
      ..where(
        (tbl) => tbl.createdBy.equals(userId),
      );

    final results = await query.get();

    return results.map(GoTaskOutputTransformer.transform).toList();
  }

  @override
  Future<void> markTaskDone(String taskId) async {
    await (_goDao.update(_goDao.goTasksTable)
          ..where((tbl) => tbl.id.equals(taskId)))
        .write(
      GoTasksTableCompanion(
        isDone: const Value(true),
        completedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> deleteTask(String id) async {
    await (_goDao.delete(_goDao.goTasksTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
