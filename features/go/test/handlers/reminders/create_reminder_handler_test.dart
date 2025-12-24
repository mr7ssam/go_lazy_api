import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoRemindersRepo extends Mock implements IGoRemindersRepo {}

class _MockGoTasksRepo extends Mock implements IGoTasksRepo {}

class _MockTransactionManager extends Mock implements TransactionManager {}

void main() {
  late _MockGoRemindersRepo remindersRepo;
  late _MockGoTasksRepo tasksRepo;
  late _MockTransactionManager transactionManager;
  late LocalizationService localization;
  late CreateReminderHandler handler;

  setUpAll(() {
    registerFallbackValue(
      GoReminder(
        id: 'reminder-id',
        taskId: 'task-id',
        userId: 'user-id',
        reminderType: GoReminderType.timeBeforeDeadline,
        minutesBefore: 30,
        isSent: false,
        createdAt: DateTime.utc(2025),
      ),
    );
    Future<void> transactionCallback() async {}
    registerFallbackValue(transactionCallback);
  });

  setUp(() {
    remindersRepo = _MockGoRemindersRepo();
    tasksRepo = _MockGoTasksRepo();
    transactionManager = _MockTransactionManager();
    localization = LocalizationService();
    handler = CreateReminderHandler(
      remindersRepo: remindersRepo,
      tasksRepo: tasksRepo,
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
  });

  group('CreateReminderHandler', () {
    test('returns success when reminder is created with valid data', () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Buy groceries',
        description: 'Get items',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-123',
        deadline: DateTime.utc(2025, 1, 20),
      );

      final createdReminder = GoReminder(
        id: 'reminder-123',
        taskId: 'task-123',
        userId: 'user-123',
        reminderType: GoReminderType.timeBeforeDeadline,
        minutesBefore: 30,
        isSent: false,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      when(() => remindersRepo.createReminder(any())).thenAnswer(
        (_) async => createdReminder,
      );

      final result = await handler.handle(
        const CreateReminderRequest(
          taskId: 'task-123',
          userId: 'user-123',
          reminderType: 'time_before_deadline',
          minutesBefore: 30,
        ),
      );

      result.when(
        success: (data) {
          expect(data.id, equals('reminder-123'));
          expect(data.reminderType, equals('time_before_deadline'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => tasksRepo.getTaskById('task-123')).called(1);
      verify(() => remindersRepo.createReminder(any())).called(1);
    });

    test('returns NotFoundError when task does not exist', () async {
      when(() => tasksRepo.getTaskById('nonexistent-task')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const CreateReminderRequest(
          taskId: 'nonexistent-task',
          userId: 'user-123',
          reminderType: 'time_before_deadline',
          minutesBefore: 30,
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
        },
      );

      verify(() => tasksRepo.getTaskById('nonexistent-task')).called(1);
      verifyNever(() => remindersRepo.createReminder(any()));
    });

    test('returns UnauthorizedError when user is not task creator', () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Buy groceries',
        description: 'Get items',
        createdBy: 'other-user',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'other-user',
        deadline: DateTime.utc(2025, 1, 20),
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      final result = await handler.handle(
        const CreateReminderRequest(
          taskId: 'task-123',
          userId: 'user-123',
          reminderType: 'time_before_deadline',
          minutesBefore: 30,
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );

      verifyNever(() => remindersRepo.createReminder(any()));
    });

    test('creates reminder with specificTime type', () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Buy groceries',
        description: 'Get items',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-123',
        deadline: DateTime.utc(2025, 1, 20),
      );

      final remindAt = DateTime.utc(2025, 1, 19, 10);
      final createdReminder = GoReminder(
        id: 'reminder-123',
        taskId: 'task-123',
        userId: 'user-123',
        reminderType: GoReminderType.specificTime,
        remindAt: remindAt,
        isSent: false,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      when(() => remindersRepo.createReminder(any())).thenAnswer(
        (_) async => createdReminder,
      );

      final result = await handler.handle(
        CreateReminderRequest(
          taskId: 'task-123',
          userId: 'user-123',
          reminderType: 'specific_time',
          remindAt: remindAt,
        ),
      );

      result.when(
        success: (data) {
          expect(data.id, equals('reminder-123'));
          expect(data.reminderType, equals('specific_time'));
          expect(data.remindAt, equals(remindAt));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      final task = GoTask(
        id: 'task-123',
        eventId: 'event-123',
        title: 'Buy groceries',
        description: 'Get items',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 15),
        isDone: false,
        isPrivate: false,
        updatedBy: 'user-123',
        deadline: DateTime.utc(2025, 1, 20),
      );

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      when(() => remindersRepo.createReminder(any())).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const CreateReminderRequest(
          taskId: 'task-123',
          userId: 'user-123',
          reminderType: 'time_before_deadline',
          minutesBefore: 30,
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
