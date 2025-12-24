import 'package:database/database.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';

class GoRecurrenceRepo implements IGoRecurrenceRepo {
  GoRecurrenceRepo({required GoDao goDao}) : _goDao = goDao;

  final GoDao _goDao;

  @override
  Future<GoRecurrence> createRecurrence(GoRecurrence recurrence) async {
    final companion = GoRecurrenceInputTransformer.transform(recurrence);
    final result = await _goDao
        .into(_goDao.goRecurrenceRulesTable)
        .insertReturning(companion);

    return GoRecurrenceOutputTransformer.transform(result);
  }

  @override
  Future<GoRecurrence?> getRecurrenceByEventId(String eventId) async {
    final query = _goDao.select(_goDao.goRecurrenceRulesTable)
      ..where((tbl) => tbl.eventId.equals(eventId));

    final result = await query.getSingleOrNull();
    return result != null
        ? GoRecurrenceOutputTransformer.transform(result)
        : null;
  }

  @override
  Future<void> updateRecurrence(GoRecurrence recurrence) async {
    await _goDao.update(_goDao.goRecurrenceRulesTable).replace(
          GoRecurrenceInputTransformer.toTableData(recurrence),
        );
  }

  @override
  Future<void> deleteRecurrence(String id) async {
    await (_goDao.delete(_goDao.goRecurrenceRulesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
