import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';

class GoEventsRepo implements IGoEventsRepo {
  GoEventsRepo({required GoDao goDao}) : _goDao = goDao;

  final GoDao _goDao;

  @override
  Future<GoEvent> createEvent(GoEvent event) async {
    final companion = GoEventInputTransformer.transform(event);
    final result =
        await _goDao.into(_goDao.goEventsTable).insertReturning(companion);

    return GoEventOutputTransformer.transform(result);
  }

  @override
  Future<void> updateEvent(GoEvent event) async {
    final companion = GoEventInputTransformer.transform(event);

    await (_goDao.update(_goDao.goEventsTable)
          ..where((tbl) => tbl.id.equals(event.id)))
        .write(companion);
  }

  @override
  Future<GoEvent?> getEventById(String id) async {
    final query = _goDao.select(_goDao.goEventsTable)
      ..where((tbl) => tbl.id.equals(id) & tbl.isActive.equals(true));
    final result = await query.getSingleOrNull();

    return result != null ? GoEventOutputTransformer.transform(result) : null;
  }

  @override
  Future<List<GoEvent>> getUserEvents(String userId) async {
    // Get events where user is creator or participant
    final query = _goDao.select(_goDao.goEventsTable).join([
      leftOuterJoin(
        _goDao.goParticipantsTable,
        _goDao.goParticipantsTable.eventId.equalsExp(
          _goDao.goEventsTable.id,
        ),
      ),
    ])
      ..where(
        (_goDao.goEventsTable.createdBy.equals(userId) |
                _goDao.goParticipantsTable.userId.equals(userId)) &
            _goDao.goEventsTable.isActive.equals(true),
      )
      ..groupBy([_goDao.goEventsTable.id]);

    final results = await query.get();

    return results
        .map(
          (row) => GoEventOutputTransformer.transform(
            row.readTable(_goDao.goEventsTable),
          ),
        )
        .toList();
  }

  @override
  Future<List<GoEvent>> getGroupEvents(String groupId) async {
    final query = _goDao.select(_goDao.goEventsTable)
      ..where(
        (tbl) => tbl.groupId.equals(groupId) & tbl.isActive.equals(true),
      );

    final results = await query.get();

    return results.map(GoEventOutputTransformer.transform).toList();
  }

  @override
  Future<void> deleteEvent(String id) async {
    await (_goDao.update(_goDao.goEventsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(const GoEventsTableCompanion(isActive: Value(false)));
  }

  @override
  Future<List<GoEvent>> getPublicEvents({
    DateTime? startDate,
    DateTime? endDate,
    int limit = 20,
    int offset = 0,
  }) async {
    final now = DateTime.now().toUtc();

    final query = _goDao.select(_goDao.goEventsTable)
      ..where(
        (tbl) =>
            tbl.visibility.equalsValue(GoVisibilityEnum.public) &
            tbl.isActive.equals(true) &
            tbl.startDate.isBiggerOrEqualValue(startDate ?? now),
      )
      ..orderBy([(t) => OrderingTerm.asc(t.startDate)])
      ..limit(limit, offset: offset);

    if (endDate != null) {
      query.where(
        (tbl) => tbl.startDate.isSmallerOrEqualValue(endDate),
      );
    }

    final results = await query.get();

    return results.map(GoEventOutputTransformer.transform).toList();
  }
}
