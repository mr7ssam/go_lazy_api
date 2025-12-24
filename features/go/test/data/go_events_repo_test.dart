import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';
import 'package:test/test.dart';

void main() {
  late GoEventsRepoTestContext context;

  setUp(() async {
    context = await GoEventsRepoTestContext.create();
  });

  tearDown(() async {
    await context.dispose();
  });

  GoEvent buildEvent({
    String? title,
    String? createdBy,
    String? groupId,
    GoVisibilityEnum? visibility,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return GoEvent.create(
      title: title ?? 'Test Event',
      createdBy: createdBy ?? 'user-123',
      groupId: groupId,
      visibility: visibility ?? GoVisibilityEnum.private,
      startDate: startDate ?? DateTime.utc(2099, 6),
      endDate: endDate ?? DateTime.utc(2099, 6, 30),
    );
  }

  group('GoEventsRepo - Event CRUD', () {
    test('createEvent inserts event and returns domain model', () async {
      final event = buildEvent(title: 'Beach Trip', createdBy: 'user-123');

      final created = await context.goEventsRepo.createEvent(event);

      expect(created.id, event.id);
      expect(created.title, 'Beach Trip');
      expect(created.createdBy, 'user-123');
      expect(created.visibility, GoVisibilityEnum.private);

      final stored = await context.goEventsRepo.getEventById(event.id);
      expect(stored, isNotNull);
      expect(stored!.title, 'Beach Trip');
    });

    test('getEventById returns stored event when found', () async {
      final event = buildEvent(title: 'Mountain Hike', groupId: 'group-456');
      await context.goEventsRepo.createEvent(event);

      final result = await context.goEventsRepo.getEventById(event.id);

      expect(result, isNotNull);
      expect(result!.id, event.id);
      expect(result.title, 'Mountain Hike');
      expect(result.groupId, 'group-456');
    });

    test('getEventById returns null when event does not exist', () async {
      final result = await context.goEventsRepo.getEventById('missing-id');

      expect(result, isNull);
    });

    test('updateEvent modifies existing event', () async {
      final event = buildEvent(title: 'Original Name', createdBy: 'user-123');
      await context.goEventsRepo.createEvent(event);

      final updated = event.copyWith(
        title: 'Updated Name',
        visibility: GoVisibilityEnum.public,
      );
      await context.goEventsRepo.updateEvent(updated);

      final stored = await context.goEventsRepo.getEventById(event.id);
      expect(stored, isNotNull);
      expect(stored!.title, 'Updated Name');
      expect(stored.visibility, GoVisibilityEnum.public);
    });

    test('deleteEvent removes event from database', () async {
      final event = buildEvent(title: 'To Delete', createdBy: 'user-123');
      await context.goEventsRepo.createEvent(event);

      await context.goEventsRepo.deleteEvent(event.id);

      final stored = await context.goEventsRepo.getEventById(event.id);
      expect(stored, isNull);
    });

    test('getUserEvents returns all events for user', () async {
      final event1 = buildEvent(title: 'Event 1', createdBy: 'user-123');
      final event2 = buildEvent(title: 'Event 2', createdBy: 'user-123');
      final event3 = buildEvent(title: 'Event 3', createdBy: 'user-456');

      await context.goEventsRepo.createEvent(event1);
      await context.goEventsRepo.createEvent(event2);
      await context.goEventsRepo.createEvent(event3);

      final result = await context.goEventsRepo.getUserEvents('user-123');

      expect(result, hasLength(2));
      expect(result.map((e) => e.title), containsAll(['Event 1', 'Event 2']));
    });

    test('getUserEvents returns empty list when no events exist', () async {
      final result = await context.goEventsRepo.getUserEvents('user-999');

      expect(result, isEmpty);
    });

    test('getGroupEvents returns all events for group', () async {
      final event1 = buildEvent(title: 'Group Event 1', groupId: 'group-789');
      final event2 = buildEvent(title: 'Group Event 2', groupId: 'group-789');
      final event3 = buildEvent(title: 'Other Event', groupId: 'group-456');

      await context.goEventsRepo.createEvent(event1);
      await context.goEventsRepo.createEvent(event2);
      await context.goEventsRepo.createEvent(event3);

      final result = await context.goEventsRepo.getGroupEvents('group-789');

      expect(result, hasLength(2));
      expect(
        result.map((e) => e.title),
        containsAll(['Group Event 1', 'Group Event 2']),
      );
    });

    test('getGroupEvents returns empty list when no events exist', () async {
      final result = await context.goEventsRepo.getGroupEvents('group-999');

      expect(result, isEmpty);
    });

    test('getPublicEvents returns only public events', () async {
      final privateEvent = buildEvent(
        title: 'Private',
        createdBy: 'user-123',
        visibility: GoVisibilityEnum.private,
      );
      final publicEvent1 = buildEvent(
        title: 'Public 1',
        createdBy: 'user-123',
        visibility: GoVisibilityEnum.public,
      );
      final publicEvent2 = buildEvent(
        title: 'Public 2',
        groupId: 'group-456',
        visibility: GoVisibilityEnum.public,
      );

      await context.goEventsRepo.createEvent(privateEvent);
      await context.goEventsRepo.createEvent(publicEvent1);
      await context.goEventsRepo.createEvent(publicEvent2);

      final result = await context.goEventsRepo.getPublicEvents();

      expect(result, hasLength(2));
      expect(result.map((e) => e.title), containsAll(['Public 1', 'Public 2']));
      expect(
        result.every((e) => e.visibility == GoVisibilityEnum.public),
        isTrue,
      );
    });

    test('getPublicEvents respects limit parameter', () async {
      for (var i = 0; i < 5; i++) {
        final event = buildEvent(
          title: 'Public Event $i',
          createdBy: 'user-123',
          visibility: GoVisibilityEnum.public,
        );
        await context.goEventsRepo.createEvent(event);
      }

      final result = await context.goEventsRepo.getPublicEvents(limit: 3);

      expect(result, hasLength(3));
    });

    test('getPublicEvents respects offset parameter', () async {
      final events = <GoEvent>[];
      for (var i = 0; i < 5; i++) {
        final event = buildEvent(
          title: 'Event $i',
          createdBy: 'user-123',
          visibility: GoVisibilityEnum.public,
          startDate: DateTime.utc(2099, 6, i + 1),
        );
        await context.goEventsRepo.createEvent(event);
        events.add(event);
      }

      final firstPage = await context.goEventsRepo.getPublicEvents(
        limit: 2,
      );
      final secondPage = await context.goEventsRepo.getPublicEvents(
        limit: 2,
        offset: 2,
      );

      expect(firstPage, hasLength(2));
      expect(secondPage, hasLength(2));
      expect(firstPage.first.id, isNot(equals(secondPage.first.id)));
    });

    test('getPublicEvents filters by date range', () async {
      final event1 = buildEvent(
        title: 'Early Event',
        createdBy: 'user-123',
        visibility: GoVisibilityEnum.public,
        startDate: DateTime.utc(2025),
      );
      final event2 = buildEvent(
        title: 'Mid Event',
        createdBy: 'user-123',
        visibility: GoVisibilityEnum.public,
        startDate: DateTime.utc(2025, 6, 15),
      );
      final event3 = buildEvent(
        title: 'Late Event',
        createdBy: 'user-123',
        visibility: GoVisibilityEnum.public,
        startDate: DateTime.utc(2025, 12, 31),
      );

      await context.goEventsRepo.createEvent(event1);
      await context.goEventsRepo.createEvent(event2);
      await context.goEventsRepo.createEvent(event3);

      final result = await context.goEventsRepo.getPublicEvents(
        startDate: DateTime.utc(2025, 6),
        endDate: DateTime.utc(2025, 6, 30),
      );

      expect(result, hasLength(1));
      expect(result.first.title, 'Mid Event');
    });

    test('getPublicEvents returns empty list when no public events', () async {
      final privateEvent = buildEvent(
        title: 'Private Only',
        createdBy: 'user-123',
        visibility: GoVisibilityEnum.private,
      );
      await context.goEventsRepo.createEvent(privateEvent);

      final result = await context.goEventsRepo.getPublicEvents();

      expect(result, isEmpty);
    });
  });
}

class GoEventsRepoTestContext {
  GoEventsRepoTestContext._({
    required this.database,
    required this.goEventsRepo,
  });

  final Database database;
  final GoEventsRepo goEventsRepo;

  static Future<GoEventsRepoTestContext> create() async {
    final database = Database(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = OFF');
    final goDao = GoDao(database);

    final goEventsRepo = GoEventsRepo(goDao: goDao);

    return GoEventsRepoTestContext._(
      database: database,
      goEventsRepo: goEventsRepo,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}
