import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';
import 'package:test/test.dart';

void main() {
  late GoParticipantsRepoTestContext context;

  setUp(() async {
    context = await GoParticipantsRepoTestContext.create();
  });

  tearDown(() async {
    await context.dispose();
  });

  group('GoParticipantsRepo - Participant CRUD', () {
    test('addParticipant inserts participant and returns domain model',
        () async {
      final participant = GoParticipant.create(
        eventId: 'event-456',
        userId: 'user-789',
        invitedBy: 'user-123',
      );

      final created =
          await context.goParticipantsRepo.addParticipant(participant);

      expect(created.id, participant.id);
      expect(created.eventId, 'event-456');
      expect(created.userId, 'user-789');
      expect(created.status, GoParticipantStatusEnum.pending);
      expect(created.invitedBy, 'user-123');
      expect(created.isActive, true);

      final stored = await context.goParticipantsRepo
          .getParticipant('event-456', 'user-789');
      expect(stored, isNotNull);
      expect(stored!.userId, 'user-789');
    });

    test('getParticipant returns stored participant when found', () async {
      final participant = GoParticipant.create(
        eventId: 'event-123',
        userId: 'user-456',
        invitedBy: 'user-789',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      final result = await context.goParticipantsRepo
          .getParticipant('event-123', 'user-456');

      expect(result, isNotNull);
      expect(result!.id, participant.id);
      expect(result.eventId, 'event-123');
      expect(result.userId, 'user-456');
    });

    test('getParticipant returns null when participant does not exist',
        () async {
      final result = await context.goParticipantsRepo
          .getParticipant('missing-event', 'missing-user');

      expect(result, isNull);
    });

    test('updateParticipantStatus modifies status and sets respondedAt',
        () async {
      final participant = GoParticipant.create(
        eventId: 'event-123',
        userId: 'user-456',
        invitedBy: 'user-789',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      await context.goParticipantsRepo.updateParticipantStatus(
        participant.id,
        GoParticipantStatusEnum.accepted,
      );

      final stored = await context.goParticipantsRepo
          .getParticipant('event-123', 'user-456');
      expect(stored, isNotNull);
      expect(stored!.status, GoParticipantStatusEnum.accepted);
      expect(stored.respondedAt, isNotNull);
    });

    test('removeParticipant soft-deletes participant', () async {
      final participant = GoParticipant.create(
        eventId: 'event-789',
        userId: 'user-321',
        invitedBy: 'user-654',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      await context.goParticipantsRepo.removeParticipant(participant.id);

      final result = await context.goParticipantsRepo
          .getParticipant('event-789', 'user-321');
      expect(result, isNull);
    });
  });

  group('GoParticipantsRepo - Queries', () {
    test('getEventParticipants returns all participants for event', () async {
      final participant1 = GoParticipant.create(
        eventId: 'event-1',
        userId: 'user-a',
        invitedBy: 'user-host',
      );
      final participant2 = GoParticipant.create(
        eventId: 'event-1',
        userId: 'user-b',
        invitedBy: 'user-host',
      );
      final participant3 = GoParticipant.create(
        eventId: 'event-2',
        userId: 'user-c',
        invitedBy: 'user-host',
      );

      await context.goParticipantsRepo.addParticipant(participant1);
      await context.goParticipantsRepo.addParticipant(participant2);
      await context.goParticipantsRepo.addParticipant(participant3);

      final result =
          await context.goParticipantsRepo.getEventParticipants('event-1');

      expect(result, hasLength(2));
      expect(result.every((p) => p.eventId == 'event-1'), isTrue);
      expect(result.map((p) => p.userId), containsAll(['user-a', 'user-b']));
    });

    test('getEventParticipants excludes removed participants', () async {
      final participant1 = GoParticipant.create(
        eventId: 'event-1',
        userId: 'user-a',
        invitedBy: 'user-host',
      );
      final participant2 = GoParticipant.create(
        eventId: 'event-1',
        userId: 'user-b',
        invitedBy: 'user-host',
      );

      await context.goParticipantsRepo.addParticipant(participant1);
      await context.goParticipantsRepo.addParticipant(participant2);

      await context.goParticipantsRepo.removeParticipant(participant1.id);

      final result =
          await context.goParticipantsRepo.getEventParticipants('event-1');

      expect(result, hasLength(1));
      expect(result.first.userId, 'user-b');
    });

    test('isUserParticipant returns true for accepted participants', () async {
      final participant = GoParticipant.create(
        eventId: 'event-123',
        userId: 'user-456',
        invitedBy: 'user-789',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      await context.goParticipantsRepo.updateParticipantStatus(
        participant.id,
        GoParticipantStatusEnum.accepted,
      );

      final result = await context.goParticipantsRepo
          .isUserParticipant('event-123', 'user-456');

      expect(result, true);
    });

    test('isUserParticipant returns false for pending participants', () async {
      final participant = GoParticipant.create(
        eventId: 'event-123',
        userId: 'user-456',
        invitedBy: 'user-789',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      final result = await context.goParticipantsRepo
          .isUserParticipant('event-123', 'user-456');

      expect(result, false);
    });

    test('isUserParticipant returns false for declined participants', () async {
      final participant = GoParticipant.create(
        eventId: 'event-123',
        userId: 'user-456',
        invitedBy: 'user-789',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      await context.goParticipantsRepo.updateParticipantStatus(
        participant.id,
        GoParticipantStatusEnum.declined,
      );

      final result = await context.goParticipantsRepo
          .isUserParticipant('event-123', 'user-456');

      expect(result, false);
    });
  });

  group('GoParticipantsRepo - Status Management', () {
    test('supports pending status', () async {
      final participant = GoParticipant.create(
        eventId: 'event-1',
        userId: 'user-1',
        invitedBy: 'user-host',
      );

      await context.goParticipantsRepo.addParticipant(participant);

      final stored =
          await context.goParticipantsRepo.getParticipant('event-1', 'user-1');
      expect(stored!.status, GoParticipantStatusEnum.pending);
      expect(stored.respondedAt, isNull);
    });

    test('supports accepted status', () async {
      final participant = GoParticipant.create(
        eventId: 'event-1',
        userId: 'user-1',
        invitedBy: 'user-host',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      await context.goParticipantsRepo.updateParticipantStatus(
        participant.id,
        GoParticipantStatusEnum.accepted,
      );

      final stored =
          await context.goParticipantsRepo.getParticipant('event-1', 'user-1');
      expect(stored!.status, GoParticipantStatusEnum.accepted);
      expect(stored.respondedAt, isNotNull);
    });

    test('supports declined status', () async {
      final participant = GoParticipant.create(
        eventId: 'event-1',
        userId: 'user-1',
        invitedBy: 'user-host',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      await context.goParticipantsRepo.updateParticipantStatus(
        participant.id,
        GoParticipantStatusEnum.declined,
      );

      final stored =
          await context.goParticipantsRepo.getParticipant('event-1', 'user-1');
      expect(stored!.status, GoParticipantStatusEnum.declined);
    });

    test('supports maybe status', () async {
      final participant = GoParticipant.create(
        eventId: 'event-1',
        userId: 'user-1',
        invitedBy: 'user-host',
      );
      await context.goParticipantsRepo.addParticipant(participant);

      await context.goParticipantsRepo.updateParticipantStatus(
        participant.id,
        GoParticipantStatusEnum.maybe,
      );

      final stored =
          await context.goParticipantsRepo.getParticipant('event-1', 'user-1');
      expect(stored!.status, GoParticipantStatusEnum.maybe);
    });
  });
}

class GoParticipantsRepoTestContext {
  GoParticipantsRepoTestContext._({
    required this.database,
    required this.goParticipantsRepo,
  });

  final Database database;
  final GoParticipantsRepo goParticipantsRepo;

  static Future<GoParticipantsRepoTestContext> create() async {
    final database = Database(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = OFF');
    final goDao = GoDao(database);

    final goParticipantsRepo = GoParticipantsRepo(goDao: goDao);

    return GoParticipantsRepoTestContext._(
      database: database,
      goParticipantsRepo: goParticipantsRepo,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}
