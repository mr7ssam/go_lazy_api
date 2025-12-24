import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoTasksRepo extends Mock implements IGoTasksRepo {}

class _MockGoEventsRepo extends Mock implements IGoEventsRepo {}

void main() {
  late _MockGoTasksRepo tasksRepo;
  late _MockGoEventsRepo eventsRepo;
  late LocalizationService localization;
  late GetEventProgressHandler handler;

  setUp(() {
    tasksRepo = _MockGoTasksRepo();
    eventsRepo = _MockGoEventsRepo();
    localization = LocalizationService();
    handler = GetEventProgressHandler(
      goTasksRepo: tasksRepo,
      goEventsRepo: eventsRepo,
      localizationService: localization,
    );
  });

  group('GetEventProgressHandler', () {
    test('returns 100% progress when all tasks are completed', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Beach Party',
        description: 'Fun day at the beach',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2),
        endDate: DateTime.utc(2025, 2, 1, 18),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'Buy drinks',
          description: '',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: true,
          isPrivate: false,
          updatedBy: 'user-123',
          completedAt: DateTime.utc(2025, 1, 20),
        ),
        GoTask(
          id: 'task-2',
          eventId: 'event-123',
          title: 'Reserve spot',
          description: '',
          createdBy: 'user-456',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: true,
          isPrivate: false,
          updatedBy: 'user-456',
          completedAt: DateTime.utc(2025, 1, 21),
        ),
      ];

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle('event-123');

      result.when(
        success: (data) {
          expect(data.progressPercent, equals(100));
          expect(data.totalTasks, equals(2));
          expect(data.completedTasks, equals(2));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => eventsRepo.getEventById('event-123')).called(1);
      verify(() => tasksRepo.getEventTasks('event-123')).called(1);
    });

    test('returns 50% progress when half of tasks are completed', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Beach Party',
        description: 'Fun day at the beach',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2),
        endDate: DateTime.utc(2025, 2, 1, 18),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'Buy drinks',
          description: '',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: true,
          isPrivate: false,
          updatedBy: 'user-123',
          completedAt: DateTime.utc(2025, 1, 20),
        ),
        GoTask(
          id: 'task-2',
          eventId: 'event-123',
          title: 'Reserve spot',
          description: '',
          createdBy: 'user-456',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-456',
        ),
      ];

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle('event-123');

      result.when(
        success: (data) {
          expect(data.progressPercent, equals(50));
          expect(data.totalTasks, equals(2));
          expect(data.completedTasks, equals(1));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns 0% progress when no tasks are completed', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Beach Party',
        description: 'Fun day at the beach',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2),
        endDate: DateTime.utc(2025, 2, 1, 18),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'Buy drinks',
          description: '',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-123',
        ),
        GoTask(
          id: 'task-2',
          eventId: 'event-123',
          title: 'Reserve spot',
          description: '',
          createdBy: 'user-456',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-456',
        ),
      ];

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle('event-123');

      result.when(
        success: (data) {
          expect(data.progressPercent, equals(0));
          expect(data.totalTasks, equals(2));
          expect(data.completedTasks, equals(0));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns 0% progress when event has no tasks', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Beach Party',
        description: 'Fun day at the beach',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2),
        endDate: DateTime.utc(2025, 2, 1, 18),
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

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => [],
      );

      final result = await handler.handle('event-123');

      result.when(
        success: (data) {
          expect(data.progressPercent, equals(0));
          expect(data.totalTasks, equals(0));
          expect(data.completedTasks, equals(0));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns NotFoundError when event does not exist', () async {
      when(() => eventsRepo.getEventById('nonexistent-event')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle('nonexistent-event');

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
        },
      );

      verifyNever(() => tasksRepo.getEventTasks(any()));
    });

    test('calculates correct percentage with rounding', () async {
      final event = GoEvent(
        id: 'event-123',
        title: 'Beach Party',
        description: 'Fun day at the beach',
        locationId: 'loc-1',
        startDate: DateTime.utc(2025, 2),
        endDate: DateTime.utc(2025, 2, 1, 18),
        groupId: 'group-1',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        updatedAt: DateTime.utc(2025, 1, 15),
        isActive: true,
        visibility: GoVisibilityEnum.public,
      );

      // 1 out of 3 tasks = 33.33% -> rounded to 33
      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'Buy drinks',
          description: '',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: true,
          isPrivate: false,
          updatedBy: 'user-123',
          completedAt: DateTime.utc(2025, 1, 20),
        ),
        GoTask(
          id: 'task-2',
          eventId: 'event-123',
          title: 'Reserve spot',
          description: '',
          createdBy: 'user-456',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-456',
        ),
        GoTask(
          id: 'task-3',
          eventId: 'event-123',
          title: 'Setup area',
          description: '',
          createdBy: 'user-789',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-789',
        ),
      ];

      when(() => eventsRepo.getEventById('event-123')).thenAnswer(
        (_) async => event,
      );

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle('event-123');

      result.when(
        success: (data) {
          expect(data.progressPercent, equals(33));
          expect(data.totalTasks, equals(3));
          expect(data.completedTasks, equals(1));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      when(() => eventsRepo.getEventById('event-123')).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle('event-123');

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<InternalServerError>());
        },
      );
    });
  });
}
