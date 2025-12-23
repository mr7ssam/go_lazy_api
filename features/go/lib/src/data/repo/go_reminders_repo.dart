import 'package:database/database.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';

class GoRemindersRepo implements IGoRemindersRepo {
  GoRemindersRepo({required GoDao goDao}) : _goDao = goDao;

  final GoDao _goDao;

  @override
  Future<GoReminder> createReminder(GoReminder reminder) async {
    final companion = GoReminderInputTransformer.transform(reminder);
    final result =
        await _goDao.into(_goDao.goRemindersTable).insertReturning(companion);

    return GoReminderOutputTransformer.transform(result);
  }

  @override
  Future<void> updateReminder(GoReminder reminder) async {
    final companion = GoReminderInputTransformer.transform(reminder);

    await (_goDao.update(_goDao.goRemindersTable)
          ..where((tbl) => tbl.id.equals(reminder.id)))
        .write(companion);
  }

  @override
  Future<GoReminder?> getReminderById(String id) async {
    final query = _goDao.select(_goDao.goRemindersTable)
      ..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();

    return result != null
        ? GoReminderOutputTransformer.transform(result)
        : null;
  }

  @override
  Future<List<GoReminder>> getTaskReminders(String taskId) async {
    final query = _goDao.select(_goDao.goRemindersTable)
      ..where((tbl) => tbl.taskId.equals(taskId));

    final results = await query.get();

    return results.map(GoReminderOutputTransformer.transform).toList();
  }

  @override
  Future<List<GoReminder>> getUserReminders(String userId) async {
    final query = _goDao.select(_goDao.goRemindersTable)
      ..where((tbl) => tbl.userId.equals(userId));

    final results = await query.get();

    return results.map(GoReminderOutputTransformer.transform).toList();
  }

  @override
  Future<void> deleteReminder(String id) async {
    await (_goDao.delete(_goDao.goRemindersTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
