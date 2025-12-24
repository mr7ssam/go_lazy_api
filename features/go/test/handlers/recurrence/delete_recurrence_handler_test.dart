import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoRecurrenceRepo extends Mock implements IGoRecurrenceRepo {}

void main() {
  late _MockGoRecurrenceRepo recurrenceRepo;
  late DeleteRecurrenceHandler handler;

  setUp(() {
    recurrenceRepo = _MockGoRecurrenceRepo();
    handler = DeleteRecurrenceHandler(recurrenceRepo: recurrenceRepo);
  });

  group('DeleteRecurrenceHandler', () {
    test('deletes recurrence successfully', () async {
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

      when(() => recurrenceRepo.deleteRecurrence('recurrence-123')).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const DeleteRecurrenceRequest(eventId: 'event-123'),
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
      verify(() => recurrenceRepo.deleteRecurrence('recurrence-123'))
          .called(1);
    });

    test('returns NotFoundError when recurrence does not exist', () async {
      when(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const DeleteRecurrenceRequest(eventId: 'event-123'),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.message, contains('Recurrence rule not found'));
        },
      );

      verify(() => recurrenceRepo.getRecurrenceByEventId('event-123'))
          .called(1);
      verifyNever(() => recurrenceRepo.deleteRecurrence(any()));
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

      when(() => recurrenceRepo.deleteRecurrence('recurrence-123')).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const DeleteRecurrenceRequest(eventId: 'event-123'),
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
