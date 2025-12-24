import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoRemindersRepo extends Mock implements IGoRemindersRepo {}

class _MockGoTasksRepo extends Mock implements IGoTasksRepo {}

void main() {
  late _MockGoRemindersRepo remindersRepo;
  late _MockGoTasksRepo tasksRepo;
  late LocalizationService localization;
  late GetTaskRemindersHandler handler;

  setUp(() {
    remindersRepo = _MockGoRemindersRepo();
    tasksRepo = _MockGoTasksRepo();
    localization = LocalizationService();
    handler = GetTaskRemindersHandler(
      remindersRepo: remindersRepo,
      tasksRepo: tasksRepo,
      localization: localization,
    );
  });

  group('GetTaskRemindersHandler', () {
    test('returns list of reminders when task exists and user is creator',
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

      final reminders = [
        GoReminder(
          id: 'reminder-1',
          taskId: 'task-123',
          userId: 'user-123',
          reminderType: GoReminderType.timeBeforeDeadline,
          minutesBefore: 30,
          isSent: false,
          createdAt: DateTime.utc(2025, 1, 15),
        ),
        GoReminder(
          id: 'reminder-2',
          taskId: 'task-123',
          userId: 'user-123',
          reminderType: GoReminderType.specificTime,
          remindAt: DateTime.utc(2025, 1, 19, 10),
          isSent: false,
          createdAt: DateTime.utc(2025, 1, 15),
        ),
      ];

      when(() => tasksRepo.getTaskById('task-123')).thenAnswer(
        (_) async => task,
      );

      when(() => remindersRepo.getTaskReminders('task-123')).thenAnswer(
        (_) async => reminders,
      );

      final result = await handler.handle(
        const GetTaskRemindersRequest(
          taskId: 'task-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.reminders.length, equals(2));
          expect(data.reminders[0].id, equals('reminder-1'));
          expect(
            data.reminders[0].reminderType,
            equals('time_before_deadline'),
          );
          expect(data.reminders[1].id, equals('reminder-2'));
          expect(data.reminders[1].reminderType, equals('specific_time'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => tasksRepo.getTaskById('task-123')).called(1);
      verify(() => remindersRepo.getTaskReminders('task-123')).called(1);
    });

    test('returns empty list when task has no reminders', () async {
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

      when(() => remindersRepo.getTaskReminders('task-123')).thenAnswer(
        (_) async => [],
      );

      final result = await handler.handle(
        const GetTaskRemindersRequest(
          taskId: 'task-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          expect(data.reminders, isEmpty);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns NotFoundError when task does not exist', () async {
      when(() => tasksRepo.getTaskById('nonexistent-task')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const GetTaskRemindersRequest(
          taskId: 'nonexistent-task',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
        },
      );

      verifyNever(() => remindersRepo.getTaskReminders(any()));
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
        const GetTaskRemindersRequest(
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

      verifyNever(() => remindersRepo.getTaskReminders(any()));
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

      when(() => remindersRepo.getTaskReminders('task-123')).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const GetTaskRemindersRequest(
          taskId: 'task-123',
          userId: 'user-123',
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
