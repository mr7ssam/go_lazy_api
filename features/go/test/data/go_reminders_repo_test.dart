import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late GoRemindersRepoTestContext context;

  setUp(() async {
    context = await GoRemindersRepoTestContext.create();
  });

  tearDown(() async {
    await context.dispose();
  });

  GoReminder buildReminder({
    String? taskId,
    String? userId,
    GoReminderType? reminderType,
    DateTime? remindAt,
    int? minutesBefore,
    bool? isSent,
  }) {
    return GoReminder(
      id: const Uuid().v4(),
      taskId: taskId ?? 'task-123',
      userId: userId ?? 'user-123',
      reminderType: reminderType ?? GoReminderType.specificTime,
      remindAt: remindAt,
      minutesBefore: minutesBefore,
      isSent: isSent ?? false,
      createdAt: DateTime.now().toUtc(),
    );
  }

  group('GoRemindersRepo - Reminder CRUD', () {
    test('createReminder inserts reminder and returns domain model', () async {
      final reminder = buildReminder(
        taskId: 'task-456',
        userId: 'user-789',
        reminderType: GoReminderType.specificTime,
        remindAt: DateTime.utc(2099, 6, 15, 9),
      );

      final created = await context.goRemindersRepo.createReminder(reminder);

      expect(created.id, reminder.id);
      expect(created.taskId, 'task-456');
      expect(created.userId, 'user-789');
      expect(created.reminderType, GoReminderType.specificTime);
      expect(created.isSent, false);

      final stored = await context.goRemindersRepo.getReminderById(reminder.id);
      expect(stored, isNotNull);
      expect(stored!.taskId, 'task-456');
    });

    test('getReminderById returns stored reminder when found', () async {
      final reminder = buildReminder(
        taskId: 'task-123',
        reminderType: GoReminderType.timeBeforeDeadline,
        minutesBefore: 30,
      );
      await context.goRemindersRepo.createReminder(reminder);

      final result = await context.goRemindersRepo.getReminderById(reminder.id);

      expect(result, isNotNull);
      expect(result!.id, reminder.id);
      expect(result.reminderType, GoReminderType.timeBeforeDeadline);
      expect(result.minutesBefore, 30);
    });

    test('getReminderById returns null when reminder does not exist', () async {
      final result =
          await context.goRemindersRepo.getReminderById('missing-id');

      expect(result, isNull);
    });

    test('updateReminder modifies existing reminder', () async {
      final reminder = buildReminder(
        taskId: 'task-123',
      );
      await context.goRemindersRepo.createReminder(reminder);

      final updated = reminder.copyWith(
        isSent: true,
        sentAt: DateTime.now().toUtc(),
      );
      await context.goRemindersRepo.updateReminder(updated);

      final stored = await context.goRemindersRepo.getReminderById(reminder.id);
      expect(stored, isNotNull);
      expect(stored!.isSent, true);
      expect(stored.sentAt, isNotNull);
    });

    test('deleteReminder removes reminder from storage', () async {
      final reminder = buildReminder(taskId: 'task-789');
      await context.goRemindersRepo.createReminder(reminder);

      await context.goRemindersRepo.deleteReminder(reminder.id);

      final result = await context.goRemindersRepo.getReminderById(reminder.id);
      expect(result, isNull);
    });
  });

  group('GoRemindersRepo - Queries', () {
    test('getTaskReminders returns reminders for specific task', () async {
      final task1Reminder1 = buildReminder(taskId: 'task-1', userId: 'user-a');
      final task1Reminder2 = buildReminder(taskId: 'task-1', userId: 'user-b');
      final task2Reminder = buildReminder(taskId: 'task-2', userId: 'user-a');

      await context.goRemindersRepo.createReminder(task1Reminder1);
      await context.goRemindersRepo.createReminder(task1Reminder2);
      await context.goRemindersRepo.createReminder(task2Reminder);

      final result = await context.goRemindersRepo.getTaskReminders('task-1');

      expect(result, hasLength(2));
      expect(result.every((r) => r.taskId == 'task-1'), isTrue);
    });

    test('getUserReminders returns reminders for specific user', () async {
      final userAReminder1 = buildReminder(taskId: 'task-1', userId: 'user-a');
      final userAReminder2 = buildReminder(taskId: 'task-2', userId: 'user-a');
      final userBReminder = buildReminder(taskId: 'task-1', userId: 'user-b');

      await context.goRemindersRepo.createReminder(userAReminder1);
      await context.goRemindersRepo.createReminder(userAReminder2);
      await context.goRemindersRepo.createReminder(userBReminder);

      final result = await context.goRemindersRepo.getUserReminders('user-a');

      expect(result, hasLength(2));
      expect(result.every((r) => r.userId == 'user-a'), isTrue);
    });

    test('supports different reminder types', () async {
      final specificTimeReminder = buildReminder(
        reminderType: GoReminderType.specificTime,
        remindAt: DateTime.utc(2099, 6, 15, 9),
      );
      final beforeEventReminder = buildReminder(
        reminderType: GoReminderType.timeBeforeEvent,
        minutesBefore: 60,
      );
      final beforeDeadlineReminder = buildReminder(
        reminderType: GoReminderType.timeBeforeDeadline,
        minutesBefore: 120,
      );

      await context.goRemindersRepo.createReminder(specificTimeReminder);
      await context.goRemindersRepo.createReminder(beforeEventReminder);
      await context.goRemindersRepo.createReminder(beforeDeadlineReminder);

      final stored1 = await context.goRemindersRepo
          .getReminderById(specificTimeReminder.id);
      final stored2 =
          await context.goRemindersRepo.getReminderById(beforeEventReminder.id);
      final stored3 = await context.goRemindersRepo
          .getReminderById(beforeDeadlineReminder.id);

      expect(stored1!.reminderType, GoReminderType.specificTime);
      expect(stored1.remindAt, isNotNull);
      expect(stored2!.reminderType, GoReminderType.timeBeforeEvent);
      expect(stored2.minutesBefore, 60);
      expect(stored3!.reminderType, GoReminderType.timeBeforeDeadline);
      expect(stored3.minutesBefore, 120);
    });
  });
}

class GoRemindersRepoTestContext {
  GoRemindersRepoTestContext._({
    required this.database,
    required this.goRemindersRepo,
  });

  final Database database;
  final GoRemindersRepo goRemindersRepo;

  static Future<GoRemindersRepoTestContext> create() async {
    final database = Database(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = OFF');
    final goDao = GoDao(database);

    final goRemindersRepo = GoRemindersRepo(goDao: goDao);

    return GoRemindersRepoTestContext._(
      database: database,
      goRemindersRepo: goRemindersRepo,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}
