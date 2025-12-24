import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoRecurrenceRepo extends Mock implements IGoRecurrenceRepo {}

class _MockGoEventsRepo extends Mock implements IGoEventsRepo {}

void main() {
  late _MockGoRecurrenceRepo recurrenceRepo;
  late _MockGoEventsRepo eventsRepo;
  late CreateRecurrenceHandler handler;

  setUpAll(() {
    registerFallbackValue(
      GoRecurrence(
        id: 'recurrence-id',
        eventId: 'event-id',
        frequency: GoFrequency.daily,
        interval: 1,
        endType: GoEndType.never,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025),
      ),
    );
  });

  setUp(() {
    recurrenceRepo = _MockGoRecurrenceRepo();
    eventsRepo = _MockGoEventsRepo();
    handler = CreateRecurrenceHandler(
      recurrenceRepo: recurrenceRepo,
      eventsRepo: eventsRepo,
    );
  });

  group('CreateRecurrenceHandler', () {
    test('creates daily recurrence successfully', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Daily Standup',
        description: 'Team standup meeting',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2, 1, 9),
        endDate: DateTime.utc(2025, 2, 1, 9, 15),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      final createdRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.daily,
        interval: 1,
        endType: GoEndType.never,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenAnswer(
        (_) async => null,
      );

      when(() => recurrenceRepo.createRecurrence(any())).thenAnswer(
        (_) async => createdRecurrence,
      );

      final result = await handler.handle(
        const CreateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.daily,
          interval: 1,
          endType: GoEndType.never,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (data) {
          expect(data.recurrence.id, equals('recurrence-123'));
          expect(data.recurrence.frequency, equals(GoFrequency.daily));
          expect(data.recurrence.interval, equals(1));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => eventsRepo.getEventById('event-123')).called(1);
      verify(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .called(1);
      verify(() => recurrenceRepo.createRecurrence(any())).called(1);
    });

    test('creates weekly recurrence with specific days', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Weekly Team Meeting',
        description: 'Team meeting every Monday and Wednesday',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2, 3, 10),
        endDate: DateTime.utc(2025, 2, 3, 11),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      final createdRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.weekly,
        interval: 1,
        daysOfWeek: ['1', '3'], // Monday and Wednesday
        endType: GoEndType.afterCount,
        endAfterCount: 10,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenAnswer(
        (_) async => null,
      );

      when(() => recurrenceRepo.createRecurrence(any())).thenAnswer(
        (_) async => createdRecurrence,
      );

      final result = await handler.handle(
        const CreateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.weekly,
          interval: 1,
          daysOfWeek: ['1', '3'],
          endType: GoEndType.afterCount,
          endAfterCount: 10,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (data) {
          expect(data.recurrence.frequency, equals(GoFrequency.weekly));
          expect(data.recurrence.daysOfWeek, equals(['1', '3']));
          expect(data.recurrence.endAfterCount, equals(10));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('creates monthly recurrence with end date', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Monthly Review',
        description: 'Monthly team review',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2, 15, 14),
        endDate: DateTime.utc(2025, 2, 15, 15),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      final endDate = DateTime.utc(2025, 12, 31);
      final createdRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.monthly,
        interval: 1,
        dayOfMonth: 15,
        endType: GoEndType.untilDate,
        endUntilDate: endDate,
        taskMode: GoTaskMode.rotate,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenAnswer(
        (_) async => null,
      );

      when(() => recurrenceRepo.createRecurrence(any())).thenAnswer(
        (_) async => createdRecurrence,
      );

      final result = await handler.handle(
        CreateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.monthly,
          interval: 1,
          dayOfMonth: 15,
          endType: GoEndType.untilDate,
          endUntilDate: endDate,
          taskMode: GoTaskMode.rotate,
        ),
      );

      result.when(
        success: (data) {
          expect(data.recurrence.frequency, equals(GoFrequency.monthly));
          expect(data.recurrence.dayOfMonth, equals(15));
          expect(data.recurrence.endUntilDate, equals(endDate));
          expect(data.recurrence.taskMode, equals(GoTaskMode.rotate));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns NotFoundError when event does not exist', () async {
      when(() => eventsRepo.getEventById('nonexistent-event')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const CreateRecurrenceRequest(
          eventId: 'nonexistent-event',
          frequency: GoFrequency.daily,
          interval: 1,
          endType: GoEndType.never,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.message, contains('Event not found'));
        },
      );

      verify(() => eventsRepo.getEventById('nonexistent-event')).called(1);
      verifyNever(() => recurrenceRepo.createRecurrence(any()));
    });

    test('returns ConflictError when event already has recurrence', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Daily Standup',
        description: 'Team standup meeting',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2, 1, 9),
        endDate: DateTime.utc(2025, 2, 1, 9, 15),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      final existingRecurrence = GoRecurrence(
        id: 'recurrence-existing',
        eventId: 'event-123',
        frequency: GoFrequency.daily,
        interval: 1,
        endType: GoEndType.never,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 10),
      );

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenAnswer(
        (_) async => existingRecurrence,
      );

      final result = await handler.handle(
        const CreateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.daily,
          interval: 1,
          endType: GoEndType.never,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<ConflictError>());
          expect(
            error.message,
            contains('Event already has a recurrence rule'),
          );
        },
      );

      verifyNever(() => recurrenceRepo.createRecurrence(any()));
    });

    test('creates yearly recurrence', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Annual Conference',
        description: 'Yearly team conference',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 6, 15, 9),
        endDate: DateTime.utc(2025, 6, 17, 17),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      final createdRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.yearly,
        interval: 1,
        endType: GoEndType.afterCount,
        endAfterCount: 5,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenAnswer(
        (_) async => null,
      );

      when(() => recurrenceRepo.createRecurrence(any())).thenAnswer(
        (_) async => createdRecurrence,
      );

      final result = await handler.handle(
        const CreateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.yearly,
          interval: 1,
          endType: GoEndType.afterCount,
          endAfterCount: 5,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (data) {
          expect(data.recurrence.frequency, equals(GoFrequency.yearly));
          expect(data.recurrence.endAfterCount, equals(5));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Daily Standup',
        description: 'Team standup meeting',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2, 1, 9),
        endDate: DateTime.utc(2025, 2, 1, 9, 15),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenAnswer(
        (_) async => null,
      );

      when(() => recurrenceRepo.createRecurrence(any())).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const CreateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.daily,
          interval: 1,
          endType: GoEndType.never,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<InternalServerError>());
        },
      );
    });
  });
}
