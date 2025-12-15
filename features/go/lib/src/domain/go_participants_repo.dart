import 'package:go/go_domain.dart';

abstract class IGoParticipantsRepo {
  Future<GoParticipant> addParticipant(GoParticipant participant);
  Future<void> updateParticipantStatus(
    String participantId,
    GoParticipantStatusEnum status,
  );
  Future<GoParticipant?> getParticipant(String eventId, String userId);
  Future<List<GoParticipant>> getEventParticipants(String eventId);
  Future<void> removeParticipant(String participantId);
  Future<bool> isUserParticipant(String eventId, String userId);
}
