import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoTasksRepo extends Mock implements IGoTasksRepo {}

class _MockGoParticipantsRepo extends Mock implements IGoParticipantsRepo {}

class _MockTransactionManager extends Mock implements TransactionManager {}

void main() {
  late _MockGoTasksRepo tasksRepo;
  late _MockGoParticipantsRepo participantsRepo;
  late _MockTransactionManager transactionManager;
  late LocalizationService localization;
  late UpdateTaskHandler handler;

  setUpAll(() {
    Future<void> transactionCallback() async {}
    registerFallbackValue(transactionCallback);
    registerFallbackValue(
      GoTask(
        id: 'task-id',
        eventId: 'event-id',
        title: 'Test Task',
        createdBy: 'user-id',
        createdAt: DateTime.utc(2025),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-id',
      ),
    );
  });

  setUp(() {
    tasksRepo = _MockGoTasksRepo();
    participantsRepo = _MockGoParticipantsRepo();
    transactionManager = _MockTransactionManager();
    localization = LocalizationService();
    handler = UpdateTaskHandler(
      tasksRepo: tasksRepo,
      participantsRepo: participantsRepo,
      transactionManager: transactionManager,
      localization: localization,
    );

    when(() => transactionManager.runInTransaction(any())).thenAnswer(
      (invocation) async {
        final callback =
            invocation.positionalArguments.first as Future<void> Function();
        await callback();
      },
    );

    when(() => participantsRepo.isUserParticipant(any(), any()))
        .thenAnswer((_) async => true);
  });

  group('UpdateTaskHandler', () {
    test('returns success when task is updated with valid data', () async {
      final existingTask = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Old title',
        description: 'Old description',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-123',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => existingTask,
      );
      when(() => tasksRepo.updateTask(any())).thenAnswer((_) async {});

      final result = await handler.handle(
        const UpdateTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
          title: 'New title',
        ),
      );

      result.when(
        success: (_) {
          // Success
        },
        failed: (error) => fail(
          'Expected success, got error: ${error.message}',
        ),
      );
      verify(() => tasksRepo.getTaskById('task-123')).called(1);
      verify(() => tasksRepo.updateTask(any())).called(1);
    });

    test('returns failed when task does not exist', () async {
      when(() => tasksRepo.getTaskById('task-999')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const UpdateTaskRequest(
          taskId: 'task-999',
          userId: 'user-123',
          title: 'New title',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
        },
      );
      verifyNever(() => tasksRepo.updateTask(any()));
    });

    test('returns failed when user is not authorized', () async {
      final existingTask = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Old title',
        description: 'Old description',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: true,
        updatedBy: 'user-123',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => existingTask,
      );

      final result = await handler.handle(
        const UpdateTaskRequest(
          taskId: 'task-123',
          userId: 'user-999', // Different user
          title: 'New title',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );
    });

    test('should fail when shared task and non-participant', () async {
      final existingTask = GoTask(
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
        (_) async => existingTask,
      );
      when(() => participantsRepo.isUserParticipant(any(), any()))
          .thenAnswer((_) async => false);

      final result = await handler.handle(
        const UpdateTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
          title: 'New title',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );
      verifyNever(() => tasksRepo.updateTask(any()));
    });

    test('should allow updating shared task when participant', () async {
      final existingTask = GoTask(
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
        (_) async => existingTask,
      );
      when(() => tasksRepo.updateTask(any())).thenAnswer((_) async {});

      final result = await handler.handle(
        const UpdateTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
          title: 'Updated title',
        ),
      );

      result.when(
        success: (_) {
          // Success
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
      verify(() => tasksRepo.updateTask(any())).called(1);
    });

    test('should fail when trying to make shared task private', () async {
      final existingTask = GoTask(
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
        (_) async => existingTask,
      );

      final result = await handler.handle(
        const UpdateTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
          isPrivate: true,
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<BadRequestError>());
        },
      );
      verifyNever(() => tasksRepo.updateTask(any()));
    });

    test('should allow making private task shared', () async {
      final existingTask = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Private task',
        description: 'My task',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: true,
        updatedBy: 'user-123',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => existingTask,
      );
      when(() => tasksRepo.updateTask(any())).thenAnswer((_) async {});

      final result = await handler.handle(
        const UpdateTaskRequest(
          taskId: 'task-123',
          userId: 'user-123',
          isPrivate: false,
        ),
      );

      result.when(
        success: (_) {
          // Success
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
      verify(() => tasksRepo.updateTask(any())).called(1);
    });
  });
}
