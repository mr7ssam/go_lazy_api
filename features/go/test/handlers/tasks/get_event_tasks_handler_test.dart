import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoTasksRepo extends Mock implements IGoTasksRepo {}

class _MockGoParticipantsRepo extends Mock implements IGoParticipantsRepo {}

void main() {
  late _MockGoTasksRepo tasksRepo;
  late _MockGoParticipantsRepo participantsRepo;
  late LocalizationService localization;
  late GetEventTasksHandler handler;

  setUp(() {
    tasksRepo = _MockGoTasksRepo();
    participantsRepo = _MockGoParticipantsRepo();
    localization = LocalizationService();
    handler = GetEventTasksHandler(
      tasksRepo: tasksRepo,
      participantsRepo: participantsRepo,
      localization: localization,
    );

    when(() => participantsRepo.isUserParticipant(any(), any()))
        .thenAnswer((_) async => true);
  });

  group('GetEventTasksHandler', () {
    test('returns success with filtered tasks for user', () async {
      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'User task 1',
          description: 'First task',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 15),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-123',
        ),
        GoTask(
          id: 'task-2',
          eventId: 'event-123',
          title: 'Other user shared task',
          description: 'Task from another user',
          createdBy: 'user-999',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-999',
        ),
        GoTask(
          id: 'task-3',
          eventId: 'event-123',
          title: 'User task 2',
          description: 'Second task',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 17),
          isDone: true,
          isPrivate: false,
          completedBy: 'user-123',
          updatedBy: 'user-123',
        ),
      ];

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle(
        const GetEventTasksRequest(
          eventId: 'event-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.tasks.length, equals(3)); // All shared tasks visible
          expect(data.tasks[0].id, equals('task-1'));
          expect(data.tasks[1].id, equals('task-2'));
          expect(data.tasks[2].id, equals('task-3'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns success with empty list when no tasks exist', () async {
      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => [],
      );

      final result = await handler.handle(
        const GetEventTasksRequest(
          eventId: 'event-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.tasks, isEmpty);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns success with empty list when no user tasks exist', () async {
      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'Other user private task',
          description: 'Task from another user',
          createdBy: 'user-999',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: true,
          updatedBy: 'user-999',
        ),
      ];

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle(
        const GetEventTasksRequest(
          eventId: 'event-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.tasks, isEmpty);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('should fail when user is not a participant', () async {
      when(() => participantsRepo.isUserParticipant(any(), any()))
          .thenAnswer((_) async => false);

      final result = await handler.handle(
        const GetEventTasksRequest(
          eventId: 'event-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );
      verifyNever(() => tasksRepo.getEventTasks(any()));
    });

    test('should filter out private tasks from other users', () async {
      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'My shared task',
          description: 'Shared',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 15),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-123',
        ),
        GoTask(
          id: 'task-2',
          eventId: 'event-123',
          title: 'Other user private task',
          description: 'Private',
          createdBy: 'user-999',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: true,
          updatedBy: 'user-999',
        ),
      ];

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle(
        const GetEventTasksRequest(
          eventId: 'event-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.tasks.length, equals(1));
          expect(data.tasks[0].id, equals('task-1'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('should include shared tasks from other users', () async {
      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'Other user shared task',
          description: 'Shared',
          createdBy: 'user-999',
          createdAt: DateTime.utc(2025, 1, 16),
          isDone: false,
          isPrivate: false,
          updatedBy: 'user-999',
        ),
      ];

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle(
        const GetEventTasksRequest(
          eventId: 'event-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.tasks.length, equals(1));
          expect(data.tasks[0].id, equals('task-1'));
          expect(data.tasks[0].isPrivate, isFalse);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('should include own private tasks', () async {
      final tasks = [
        GoTask(
          id: 'task-1',
          eventId: 'event-123',
          title: 'My private task',
          description: 'Private',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025, 1, 15),
          isDone: false,
          isPrivate: true,
          updatedBy: 'user-123',
        ),
      ];

      when(() => tasksRepo.getEventTasks('event-123')).thenAnswer(
        (_) async => tasks,
      );

      final result = await handler.handle(
        const GetEventTasksRequest(
          eventId: 'event-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.tasks.length, equals(1));
          expect(data.tasks[0].id, equals('task-1'));
          expect(data.tasks[0].isPrivate, isTrue);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });
  });
}
