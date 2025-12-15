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
  late CreateTaskHandler handler;

  setUpAll(() {
    registerFallbackValue(
      GoTask(
        id: 'task-id',
        eventId: 'event-id',
        title: 'Test Task',
        description: 'Task description',
        createdBy: 'user-id',
        createdAt: DateTime.utc(2025),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-id',
      ),
    );
    Future<void> transactionCallback() async {}
    registerFallbackValue(transactionCallback);
  });

  setUp(() {
    tasksRepo = _MockGoTasksRepo();
    participantsRepo = _MockGoParticipantsRepo();
    transactionManager = _MockTransactionManager();
    localization = LocalizationService();
    handler = CreateTaskHandler(
      tasksRepo: tasksRepo,
      participantsRepo: participantsRepo,
      transactionManager: transactionManager,
      localization: localization,
    );

    when(() => transactionManager.runInTransaction(any())).thenAnswer(
      (invocation) async {
        final callback =
            invocation.positionalArguments.first as Future<void> Function();
        return callback();
      },
    );

    when(() => participantsRepo.isUserParticipant(any(), any()))
        .thenAnswer((_) async => true);
  });

  group('CreateTaskHandler', () {
    test('returns success when task is created with valid data', () async {
      final createdTask = GoTask(
        id: 'new-task-id',
        eventId: 'event-123',
        title: 'Buy groceries',
        description: 'Get items for the event',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-123',
      );

      when(() => tasksRepo.createTask(any())).thenAnswer(
        (_) async => createdTask,
      );

      final result = await handler.handle(
        const CreateTaskRequest(
          eventId: 'event-123',
          title: 'Buy groceries',
          createdBy: 'user-123',
          description: 'Get items for the event',
        ),
      );

      result.when(
        success: (data) {
          expect(data.id, equals('new-task-id'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
      verify(() => tasksRepo.createTask(any())).called(1);
      verify(() => participantsRepo.isUserParticipant('event-123', 'user-123'))
          .called(1);
    });

    test('returns failed when repository throws InternalServerError', () async {
      when(() => tasksRepo.createTask(any())).thenThrow(
        InternalServerError(message: 'Database error'),
      );

      final result = await handler.handle(
        const CreateTaskRequest(
          eventId: 'event-123',
          title: 'Buy groceries',
          createdBy: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<InternalServerError>());
        },
      );
    });

    test('should fail when user is not a participant', () async {
      when(() => participantsRepo.isUserParticipant(any(), any()))
          .thenAnswer((_) async => false);

      final result = await handler.handle(
        const CreateTaskRequest(
          eventId: 'event-123',
          title: 'Buy groceries',
          createdBy: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );
      verifyNever(() => tasksRepo.createTask(any()));
    });

    test('should create private task when isPrivate is true', () async {
      final createdTask = GoTask(
        id: 'new-task-id',
        eventId: 'event-123',
        title: 'Private task',
        description: 'My personal task',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: true,
        updatedBy: 'user-123',
      );

      when(() => tasksRepo.createTask(any())).thenAnswer(
        (_) async => createdTask,
      );

      final result = await handler.handle(
        const CreateTaskRequest(
          eventId: 'event-123',
          title: 'Private task',
          createdBy: 'user-123',
          description: 'My personal task',
          isPrivate: true,
        ),
      );

      result.when(
        success: (data) {
          expect(data.id, equals('new-task-id'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
      verify(() => tasksRepo.createTask(any())).called(1);
    });
  });
}
