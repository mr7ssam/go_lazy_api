import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';

class GoParticipantsRepo implements IGoParticipantsRepo {
  GoParticipantsRepo({required GoDao goDao}) : _goDao = goDao;

  final GoDao _goDao;

  @override
  Future<GoParticipant> addParticipant(GoParticipant participant) async {
    final companion = GoParticipantInputTransformer.transform(participant);
    final result = await _goDao
        .into(_goDao.goParticipantsTable)
        .insertReturning(companion);

    return GoParticipantOutputTransformer.transform(result);
  }

  @override
  Future<void> updateParticipantStatus(
    String participantId,
    GoParticipantStatusEnum status,
  ) async {
    await (_goDao.update(_goDao.goParticipantsTable)
          ..where((tbl) => tbl.id.equals(participantId)))
        .write(
      GoParticipantsTableCompanion(
        status: Value(status),
        respondedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<GoParticipant?> getParticipant(String eventId, String userId) async {
    final query = _goDao.select(_goDao.goParticipantsTable)
      ..where(
        (tbl) =>
            tbl.eventId.equals(eventId) &
            tbl.userId.equals(userId) &
            tbl.isActive.equals(true),
      );
    final result = await query.getSingleOrNull();

    return result != null
        ? GoParticipantOutputTransformer.transform(result)
        : null;
  }

  @override
  Future<List<GoParticipant>> getEventParticipants(String eventId) async {
    final query = _goDao.select(_goDao.goParticipantsTable)
      ..where(
        (tbl) => tbl.eventId.equals(eventId) & tbl.isActive.equals(true),
      );

    final results = await query.get();

    return results.map(GoParticipantOutputTransformer.transform).toList();
  }

  @override
  Future<void> removeParticipant(String participantId) async {
    await (_goDao.update(_goDao.goParticipantsTable)
          ..where((tbl) => tbl.id.equals(participantId)))
        .write(const GoParticipantsTableCompanion(isActive: Value(false)));
  }

  @override
  Future<bool> isUserParticipant(String eventId, String userId) async {
    final query = _goDao.select(_goDao.goParticipantsTable)
      ..where(
        (tbl) =>
            tbl.eventId.equals(eventId) &
            tbl.userId.equals(userId) &
            tbl.isActive.equals(true) &
            tbl.status.equals(GoParticipantStatusEnum.accepted.name),
      );

    final result = await query.getSingleOrNull();
    return result != null;
  }
}
