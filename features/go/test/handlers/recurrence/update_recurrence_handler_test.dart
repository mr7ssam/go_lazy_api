import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoRecurrenceRepo extends Mock implements IGoRecurrenceRepo {}

void main() {
  late _MockGoRecurrenceRepo recurrenceRepo;
  late UpdateRecurrenceHandler handler;

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
    handler = UpdateRecurrenceHandler(recurrenceRepo: recurrenceRepo);
  });

  group('UpdateRecurrenceHandler', () {
    test('updates recurrence successfully', () async {
      final existingRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.daily,
        interval: 1,
        endType: GoEndType.never,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .thenAnswer(
        (_) async => existingRecurrence,
      );

      when(() => recurrenceRepo.updateRecurrence(any())).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const UpdateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.weekly,
          interval: 2,
          daysOfWeek: ['1', '3', '5'],
          endType: GoEndType.afterCount,
          endAfterCount: 10,
          taskMode: GoTaskMode.rotate,
        ),
      );

      result.when(
        success: (data) {
          // Success - no data returned
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .called(1);
      verify(() => recurrenceRepo.updateRecurrence(any())).called(1);
    });

    test('updates recurrence from never to untilDate', () async {
      final existingRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.daily,
        interval: 1,
        endType: GoEndType.never,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .thenAnswer(
        (_) async => existingRecurrence,
      );

      when(() => recurrenceRepo.updateRecurrence(any())).thenAnswer(
        (_) async {},
      );

      final endDate = DateTime.utc(2025, 12, 31);
      final result = await handler.handle(
        UpdateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.daily,
          interval: 1,
          endType: GoEndType.untilDate,
          endUntilDate: endDate,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (data) {
          // Success - no data returned
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => recurrenceRepo.updateRecurrence(any())).called(1);
    });

    test('updates task mode from copy to rotate', () async {
      final existingRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.weekly,
        interval: 1,
        daysOfWeek: ['1', '3'],
        endType: GoEndType.never,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .thenAnswer(
        (_) async => existingRecurrence,
      );

      when(() => recurrenceRepo.updateRecurrence(any())).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const UpdateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.weekly,
          interval: 1,
          daysOfWeek: ['1', '3'],
          endType: GoEndType.never,
          taskMode: GoTaskMode.rotate,
        ),
      );

      result.when(
        success: (data) {
          // Success - no data returned
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns NotFoundError when recurrence does not exist', () async {
      when(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const UpdateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.weekly,
          interval: 1,
          endType: GoEndType.never,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.message, contains('Recurrence rule not found'));
        },
      );

      verifyNever(() => recurrenceRepo.updateRecurrence(any()));
    });

    test('updates monthly recurrence pattern', () async {
      final existingRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.monthly,
        interval: 1,
        dayOfMonth: 1,
        endType: GoEndType.never,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .thenAnswer(
        (_) async => existingRecurrence,
      );

      when(() => recurrenceRepo.updateRecurrence(any())).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const UpdateRecurrenceRequest(
          eventId: 'event-123',
          frequency: GoFrequency.monthly,
          interval: 1,
          weekOfMonth: 1,
          dayOfWeekInMonth: '1',
          endType: GoEndType.never,
          taskMode: GoTaskMode.copy,
        ),
      );

      result.when(
        success: (data) {
          // Success - no data returned
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      final existingRecurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.daily,
        interval: 1,
        endType: GoEndType.never,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .thenAnswer(
        (_) async => existingRecurrence,
      );

      when(() => recurrenceRepo.updateRecurrence(any())).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const UpdateRecurrenceRequest(
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
