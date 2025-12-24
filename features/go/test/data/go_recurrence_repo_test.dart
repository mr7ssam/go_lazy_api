import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late GoRecurrenceRepoTestContext context;

  setUp(() async {
    context = await GoRecurrenceRepoTestContext.create();
  });

  tearDown(() async {
    await context.dispose();
  });

  GoRecurrence buildRecurrence({
    String? eventId,
    GoFrequency? frequency,
    int? interval,
    GoEndType? endType,
    GoTaskMode? taskMode,
    List<String>? daysOfWeek,
    int? endAfterCount,
    DateTime? endUntilDate,
  }) {
    return GoRecurrence(
      id: const Uuid().v4(),
      eventId: eventId ?? 'event-123',
      frequency: frequency ?? GoFrequency.daily,
      interval: interval ?? 1,
      endType: endType ?? GoEndType.never,
      taskMode: taskMode ?? GoTaskMode.copy,
      daysOfWeek: daysOfWeek,
      endAfterCount: endAfterCount,
      endUntilDate: endUntilDate,
      createdAt: DateTime.now().toUtc(),
    );
  }

  group('GoRecurrenceRepo - Recurrence CRUD', () {
    test('createRecurrence inserts recurrence and returns domain model',
        () async {
      final recurrence = buildRecurrence(
        eventId: 'event-456',
        frequency: GoFrequency.weekly,
        interval: 2,
        daysOfWeek: ['monday', 'wednesday', 'friday'],
        endType: GoEndType.afterCount,
        endAfterCount: 10,
      );

      final created =
          await context.goRecurrenceRepo.createRecurrence(recurrence);

      expect(created.id, recurrence.id);
      expect(created.eventId, 'event-456');
      expect(created.frequency, GoFrequency.weekly);
      expect(created.interval, 2);
      expect(created.daysOfWeek, ['monday', 'wednesday', 'friday']);
      expect(created.endType, GoEndType.afterCount);
      expect(created.endAfterCount, 10);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-456');
      expect(stored, isNotNull);
      expect(stored!.frequency, GoFrequency.weekly);
    });

    test('getRecurrenceByEventId returns stored recurrence when found',
        () async {
      final recurrence = buildRecurrence(
        eventId: 'event-789',
        frequency: GoFrequency.monthly,
        endType: GoEndType.untilDate,
        endUntilDate: DateTime.utc(2099, 12, 31),
      );
      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final result =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-789');

      expect(result, isNotNull);
      expect(result!.id, recurrence.id);
      expect(result.frequency, GoFrequency.monthly);
      expect(result.endType, GoEndType.untilDate);
    });

    test('getRecurrenceByEventId returns null when recurrence does not exist',
        () async {
      final result = await context.goRecurrenceRepo
          .getRecurrenceByEventId('missing-event');

      expect(result, isNull);
    });

    test('updateRecurrence modifies existing recurrence', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-123',
        frequency: GoFrequency.daily,
        interval: 1,
      );
      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final updated = recurrence.copyWith(
        frequency: GoFrequency.weekly,
        interval: 3,
        daysOfWeek: ['saturday', 'sunday'],
      );
      await context.goRecurrenceRepo.updateRecurrence(updated);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-123');
      expect(stored, isNotNull);
      expect(stored!.frequency, GoFrequency.weekly);
      expect(stored.interval, 3);
      expect(stored.daysOfWeek, ['saturday', 'sunday']);
    });

    test('deleteRecurrence removes recurrence from storage', () async {
      final recurrence = buildRecurrence(eventId: 'event-999');
      await context.goRecurrenceRepo.createRecurrence(recurrence);

      await context.goRecurrenceRepo.deleteRecurrence(recurrence.id);

      final result =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-999');
      expect(result, isNull);
    });
  });

  group('GoRecurrenceRepo - Frequency Types', () {
    test('supports daily frequency', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-daily',
        frequency: GoFrequency.daily,
        interval: 1,
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-daily');
      expect(stored!.frequency, GoFrequency.daily);
      expect(stored.interval, 1);
    });

    test('supports weekly frequency with specific days', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-weekly',
        frequency: GoFrequency.weekly,
        interval: 1,
        daysOfWeek: ['tuesday', 'thursday'],
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-weekly');
      expect(stored!.frequency, GoFrequency.weekly);
      expect(stored.daysOfWeek, ['tuesday', 'thursday']);
    });

    test('supports monthly frequency', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-monthly',
        frequency: GoFrequency.monthly,
        interval: 2,
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored = await context.goRecurrenceRepo
          .getRecurrenceByEventId('event-monthly');
      expect(stored!.frequency, GoFrequency.monthly);
      expect(stored.interval, 2);
    });

    test('supports yearly frequency', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-yearly',
        frequency: GoFrequency.yearly,
        interval: 1,
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-yearly');
      expect(stored!.frequency, GoFrequency.yearly);
    });
  });

  group('GoRecurrenceRepo - End Types', () {
    test('supports never ending recurrence', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-never',
        endType: GoEndType.never,
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-never');
      expect(stored!.endType, GoEndType.never);
      expect(stored.endAfterCount, isNull);
      expect(stored.endUntilDate, isNull);
    });

    test('supports ending after count', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-count',
        endType: GoEndType.afterCount,
        endAfterCount: 15,
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-count');
      expect(stored!.endType, GoEndType.afterCount);
      expect(stored.endAfterCount, 15);
    });

    test('supports ending until date', () async {
      final endDate = DateTime.utc(2099, 6, 30);
      final recurrence = buildRecurrence(
        eventId: 'event-until',
        endType: GoEndType.untilDate,
        endUntilDate: endDate,
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-until');
      expect(stored!.endType, GoEndType.untilDate);
      expect(stored.endUntilDate!.year, 2099);
      expect(stored.endUntilDate!.month, 6);
      expect(stored.endUntilDate!.day, 30);
    });
  });

  group('GoRecurrenceRepo - Task Modes', () {
    test('supports copy task mode', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-copy',
        taskMode: GoTaskMode.copy,
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-copy');
      expect(stored!.taskMode, GoTaskMode.copy);
    });

    test('supports rotate task mode', () async {
      final recurrence = buildRecurrence(
        eventId: 'event-rotate',
        taskMode: GoTaskMode.rotate,
      );

      await context.goRecurrenceRepo.createRecurrence(recurrence);

      final stored =
          await context.goRecurrenceRepo.getRecurrenceByEventId('event-rotate');
      expect(stored!.taskMode, GoTaskMode.rotate);
    });
  });
}

class GoRecurrenceRepoTestContext {
  GoRecurrenceRepoTestContext._({
    required this.database,
    required this.goRecurrenceRepo,
  });

  final Database database;
  final GoRecurrenceRepo goRecurrenceRepo;

  static Future<GoRecurrenceRepoTestContext> create() async {
    final database = Database(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = OFF');
    final goDao = GoDao(database);

    final goRecurrenceRepo = GoRecurrenceRepo(goDao: goDao);

    return GoRecurrenceRepoTestContext._(
      database: database,
      goRecurrenceRepo: goRecurrenceRepo,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}
