import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoRecurrenceRepo extends Mock implements IGoRecurrenceRepo {}

void main() {
  late _MockGoRecurrenceRepo recurrenceRepo;
  late GetRecurrenceHandler handler;

  setUp(() {
    recurrenceRepo = _MockGoRecurrenceRepo();
    handler = GetRecurrenceHandler(recurrenceRepo: recurrenceRepo);
  });

  group('GetRecurrenceHandler', () {
    test('returns recurrence when it exists', () async {
      final recurrence = GoRecurrence(
        id: 'recurrence-123',
        eventId: 'event-123',
        frequency: GoFrequency.weekly,
        interval: 1,
        daysOfWeek: ['1', '3', '5'],
        endType: GoEndType.afterCount,
        endAfterCount: 10,
        taskMode: GoTaskMode.copy,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenAnswer(
        (_) async => recurrence,
      );

      final result = await handler.handle(
        const GetRecurrenceRequest(eventId: 'event-123'),
      );

      result.when(
        success: (data) {
          expect(data.recurrence, isNotNull);
          expect(data.recurrence!.id, equals('recurrence-123'));
          expect(data.recurrence!.frequency, equals(GoFrequency.weekly));
          expect(data.recurrence!.daysOfWeek, equals(['1', '3', '5']));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .called(1);
    });

    test('returns null recurrence when event has no recurrence rule', () async {
      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const GetRecurrenceRequest(eventId: 'event-123'),
      );

      result.when(
        success: (data) {
          expect(data.recurrence, isNull);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .called(1);
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      when(() => recurrenceRepo.getRecurrenceByEventId('event-123')).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const GetRecurrenceRequest(eventId: 'event-123'),
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
