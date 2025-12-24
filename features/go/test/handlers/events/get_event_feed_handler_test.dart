import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoEventsRepo extends Mock implements IGoEventsRepo {}

void main() {
  late _MockGoEventsRepo eventsRepo;
  late LocalizationService localization;
  late GetEventFeedHandler handler;

  setUp(() {
    eventsRepo = _MockGoEventsRepo();
    localization = LocalizationService();
    handler = GetEventFeedHandler(
      goEventsRepo: eventsRepo,
      localizationService: localization,
    );
  });

  group('GetEventFeedHandler', () {
    test('returns list of public events with pagination', () async {
      final events = [
        GoEvent(
          id: 'event-1',
          title: 'Beach Party',
          description: 'Fun at the beach',
          locationId: 'loc-1',
          startDate: DateTime.utc(2025, 2),
          endDate: DateTime.utc(2025, 2, 1, 18),
          groupId: 'group-1',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 15),
          updatedAt: DateTime.utc(2025, 1, 15),
          isActive: true,
          visibility: GoVisibilityEnum.public,
        ),
        GoEvent(
          id: 'event-2',
          title: 'Hiking Trip',
          description: 'Mountain hiking',
          locationId: 'loc-2',
          startDate: DateTime.utc(2025, 2, 5),
          endDate: DateTime.utc(2025, 2, 5, 16),
          groupId: 'group-2',
          createdBy: 'user-456',
          createdAt: DateTime.utc(2025, 1, 16),
          updatedAt: DateTime.utc(2025, 1, 16),
          isActive: true,
          visibility: GoVisibilityEnum.public,
        ),
      ];

      when(
        () => eventsRepo.getPublicEvents(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          limit: 21,
        ),
      ).thenAnswer((_) async => events);

      final result = await handler.handle(
        GetEventFeedRequest(),
      );

      result.when(
        success: (data) {
          expect(data.events.length, equals(2));
          expect(data.events[0].id, equals('event-1'));
          expect(data.events[0].title, equals('Beach Party'));
          expect(data.events[1].id, equals('event-2'));
          expect(data.hasMore, isFalse);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(
        () => eventsRepo.getPublicEvents(
          limit: 21,
        ),
      ).called(1);
    });

    test('indicates hasMore when there are more events', () async {
      final events = List.generate(
        21,
        (i) => GoEvent(
          id: 'event-$i',
          title: 'Event $i',
          description: 'Description $i',
          locationId: 'loc-$i',
          startDate: DateTime.utc(2025, 2, i + 1),
          endDate: DateTime.utc(2025, 2, i + 1, 18),
          groupId: 'group-$i',
          createdBy: 'user-$i',
          createdAt: DateTime.utc(2025, 1, 15),
          updatedAt: DateTime.utc(2025, 1, 15),
          isActive: true,
          visibility: GoVisibilityEnum.public,
        ),
      );

      when(
        () => eventsRepo.getPublicEvents(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          limit: 21,
        ),
      ).thenAnswer((_) async => events);

      final result = await handler.handle(
        GetEventFeedRequest(),
      );

      result.when(
        success: (data) {
          expect(data.events.length, equals(20));
          expect(data.hasMore, isTrue);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('filters events by date range', () async {
      final startDate = DateTime.utc(2025, 2);
      final endDate = DateTime.utc(2025, 2, 28);

      final events = [
        GoEvent(
          id: 'event-1',
          title: 'February Event',
          description: 'Event in February',
          locationId: 'loc-1',
          startDate: DateTime.utc(2025, 2, 10),
          endDate: DateTime.utc(2025, 2, 10, 18),
          groupId: 'group-1',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 15),
          updatedAt: DateTime.utc(2025, 1, 15),
          isActive: true,
          visibility: GoVisibilityEnum.public,
        ),
      ];

      when(
        () => eventsRepo.getPublicEvents(
          startDate: startDate,
          endDate: endDate,
          limit: 21,
        ),
      ).thenAnswer((_) async => events);

      final result = await handler.handle(
        GetEventFeedRequest(
          startDate: startDate,
          endDate: endDate,
        ),
      );

      result.when(
        success: (data) {
          expect(data.events.length, equals(1));
          expect(data.events[0].title, equals('February Event'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(
        () => eventsRepo.getPublicEvents(
          startDate: startDate,
          endDate: endDate,
          limit: 21,
        ),
      ).called(1);
    });

    test('returns empty list when no events found', () async {
      when(
        () => eventsRepo.getPublicEvents(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          limit: 21,
        ),
      ).thenAnswer((_) async => []);

      final result = await handler.handle(
        GetEventFeedRequest(),
      );

      result.when(
        success: (data) {
          expect(data.events, isEmpty);
          expect(data.hasMore, isFalse);
          expect(data.total, equals(0));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns BadRequestError when limit is 0', () async {
      final result = await handler.handle(
        GetEventFeedRequest(limit: 0),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<BadRequestError>());
          expect(error.message, contains('Limit must be between 1 and 100'));
        },
      );

      verifyNever(
        () => eventsRepo.getPublicEvents(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      );
    });

    test('returns BadRequestError when limit exceeds 100', () async {
      final result = await handler.handle(
        GetEventFeedRequest(limit: 101),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<BadRequestError>());
          expect(error.message, contains('Limit must be between 1 and 100'));
        },
      );
    });

    test('returns BadRequestError when offset is negative', () async {
      final result = await handler.handle(
        GetEventFeedRequest(offset: -1),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<BadRequestError>());
          expect(error.message, contains('Offset must be non-negative'));
        },
      );
    });

    test('returns BadRequestError when end date is before start date',
        () async {
      final startDate = DateTime.utc(2025, 2, 28);
      final endDate = DateTime.utc(2025, 2);

      final result = await handler.handle(
        GetEventFeedRequest(
          startDate: startDate,
          endDate: endDate,
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<BadRequestError>());
          expect(error.message, contains('End date must be after start date'));
        },
      );
    });

    test('handles pagination with offset', () async {
      final events = [
        GoEvent(
          id: 'event-21',
          title: 'Event 21',
          description: 'Description',
          locationId: 'loc-21',
          startDate: DateTime.utc(2025, 3),
          endDate: DateTime.utc(2025, 3, 1, 18),
          groupId: 'group-21',
          createdBy: 'user-21',
          createdAt: DateTime.utc(2025, 1, 15),
          updatedAt: DateTime.utc(2025, 1, 15),
          isActive: true,
          visibility: GoVisibilityEnum.public,
        ),
      ];

      when(
        () => eventsRepo.getPublicEvents(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          limit: 21,
          offset: 20,
        ),
      ).thenAnswer((_) async => events);

      final result = await handler.handle(
        GetEventFeedRequest(offset: 20),
      );

      result.when(
        success: (data) {
          expect(data.events.length, equals(1));
          expect(data.events[0].id, equals('event-21'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(
        () => eventsRepo.getPublicEvents(
          limit: 21,
          offset: 20,
        ),
      ).called(1);
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      when(
        () => eventsRepo.getPublicEvents(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenThrow(Exception('Database error'));

      final result = await handler.handle(
        GetEventFeedRequest(),
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
