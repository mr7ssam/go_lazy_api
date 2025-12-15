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
  late GetTaskHandler handler;

  setUp(() {
    tasksRepo = _MockGoTasksRepo();
    participantsRepo = _MockGoParticipantsRepo();
    localization = LocalizationService();
    handler = GetTaskHandler(
      tasksRepo: tasksRepo,
      participantsRepo: participantsRepo,
      localization: localization,
    );

    when(() => participantsRepo.isUserParticipant(any(), any()))
        .thenAnswer((_) async => true);
  });

  group('GetTaskHandler', () {
    test('returns success when task exists and user is authorized', () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Buy groceries',
        description: 'Get items for the event',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-123',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      final result = await handler.handle(
        const GetTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.id, equals('task-123'));
          expect(data.title, equals('Buy groceries'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
      verify(() => tasksRepo.getTaskById('task-123')).called(1);
    });

    test('returns failed when task does not exist', () async {
      when(() => tasksRepo.getTaskById('task-999')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const GetTaskRequest(
          taskId: 'task-999',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
        },
      );
    });

    test('returns failed when user is not authorized', () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Buy groceries',
        description: 'Get items for the event',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: true,
        updatedBy: 'user-123',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      final result = await handler.handle(
        const GetTaskRequest(
          taskId: 'task-123',
          userId: 'user-999', // Different user
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );
    });

    test("should fail when accessing other user's private task", () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Private task',
        description: 'Someone else private task',
        createdBy: 'user-999',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: true,
        updatedBy: 'user-999',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      final result = await handler.handle(
        const GetTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );
    });

    test('should allow accessing shared task when participant', () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Shared task',
        description: 'Team task',
        createdBy: 'user-999',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-999',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      final result = await handler.handle(
        const GetTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.id, equals('task-123'));
          expect(data.isPrivate, isFalse);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('should fail when accessing shared task as non-participant', () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Shared task',
        description: 'Team task',
        createdBy: 'user-999',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-999',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );
      when(() => participantsRepo.isUserParticipant(any(), any()))
          .thenAnswer((_) async => false);

      final result = await handler.handle(
        const GetTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );
    });
  });
}
