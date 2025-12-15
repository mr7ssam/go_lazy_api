import 'package:uuid/uuid.dart';

enum GoParticipantStatusEnum {
  pending,
  accepted,
  declined,
  maybe,
}

class GoParticipant {
  GoParticipant({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.status,
    required this.invitedBy,
    required this.invitedAt,
    required this.isActive,
    this.respondedAt,
  });

  factory GoParticipant.create({
    required String eventId,
    required String userId,
    required String invitedBy,
    GoParticipantStatusEnum status = GoParticipantStatusEnum.pending,
  }) {
    return GoParticipant(
      id: const Uuid().v4(),
      eventId: eventId,
      userId: userId,
      status: status,
      invitedBy: invitedBy,
      invitedAt: DateTime.now().toUtc(),
      isActive: true,
    );
  }

  final String id;
  final String eventId;
  final String userId;
  final GoParticipantStatusEnum status;
  final String invitedBy;
  final DateTime invitedAt;
  final DateTime? respondedAt;
  final bool isActive;

  GoParticipant copyWith({
    String? id,
    String? eventId,
    String? userId,
    GoParticipantStatusEnum? status,
    String? invitedBy,
    DateTime? invitedAt,
    DateTime? respondedAt,
    bool? isActive,
  }) {
    return GoParticipant(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      invitedBy: invitedBy ?? this.invitedBy,
      invitedAt: invitedAt ?? this.invitedAt,
      respondedAt: respondedAt ?? this.respondedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
