import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';

class GoParticipantInputTransformer {
  static Insertable<GoParticipantsTableData> transform(
    GoParticipant participant,
  ) {
    return GoParticipantsTableCompanion(
      id: Value(participant.id),
      eventId: Value(participant.eventId),
      userId: Value(participant.userId),
      status: Value(participant.status),
      invitedBy: Value(participant.invitedBy),
      invitedAt: Value(participant.invitedAt),
      respondedAt: Value(participant.respondedAt),
      isActive: Value(participant.isActive),
    );
  }
}

class GoParticipantOutputTransformer {
  static GoParticipant transform(GoParticipantsTableData data) {
    return GoParticipant(
      id: data.id,
      eventId: data.eventId,
      userId: data.userId,
      status: data.status,
      invitedBy: data.invitedBy,
      invitedAt: data.invitedAt,
      respondedAt: data.respondedAt,
      isActive: data.isActive,
    );
  }
}
