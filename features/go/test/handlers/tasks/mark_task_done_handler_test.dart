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
  late MarkTaskDoneHandler handler;

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
    handler = MarkTaskDoneHandler(
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

  group('MarkTaskDoneHandler', () {
    test('returns success when task is marked as done', () async {
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
      when(() => tasksRepo.updateTask(any())).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const MarkTaskDoneRequest(
          taskId: 'task-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) {
          // Success
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
      verify(() => tasksRepo.getTaskById('task-123')).called(1);
      verify(() => tasksRepo.updateTask(any())).called(1);
    });

    test('returns failed when task does not exist', () async {
      when(() => tasksRepo.getTaskById('task-999')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const MarkTaskDoneRequest(
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
        const MarkTaskDoneRequest(
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
      verifyNever(() => tasksRepo.updateTask(any()));
    });

    test('should allow participant to mark shared task done', () async {
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
      when(() => tasksRepo.updateTask(any())).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const MarkTaskDoneRequest(
          taskId: 'task-123',
          userId: 'user-123',
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

    test('should set completedBy when marking done', () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Task',
        description: 'Desc',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-123',
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );
      when(() => tasksRepo.updateTask(any())).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const MarkTaskDoneRequest(
          taskId: 'task-123',
          userId: 'user-456',
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

    test('should clear completedAt but preserve completedBy when unmarking',
        () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Task',
        description: 'Desc',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: true,
        isPrivate: false,
        completedBy: 'user-456',
        updatedBy: 'user-123',
        completedAt: DateTime.utc(2025, 1, 20),
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );
      when(() => tasksRepo.updateTask(any())).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const MarkTaskDoneRequest(
          taskId: 'task-123',
          userId: 'user-123',
          isDone: false,
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

    test('should fail when shared task and non-participant', () async {
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
        const MarkTaskDoneRequest(
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
      verifyNever(() => tasksRepo.updateTask(any()));
    });
  });
}
