import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';
import 'package:test/test.dart';

void main() {
  late GoTasksRepoTestContext context;

  setUp(() async {
    context = await GoTasksRepoTestContext.create();
  });

  tearDown(() async {
    await context.dispose();
  });

  GoEvent buildEvent({
    String? title,
    String? createdBy,
  }) {
    return GoEvent.create(
      title: title ?? 'Test Event',
      createdBy: createdBy ?? 'user-123',
      visibility: GoVisibilityEnum.private,
      startDate: DateTime.utc(2025, 6),
      endDate: DateTime.utc(2025, 6, 30),
    );
  }

  GoTask buildTask({
    String? title,
    String? eventId,
    String? createdBy,
    bool? isPrivate,
    DateTime? deadline,
  }) {
    return GoTask.create(
      title: title ?? 'Test Task',
      eventId: eventId ?? 'event-123',
      createdBy: createdBy ?? 'user-123',
      isPrivate: isPrivate ?? true,
      deadline: deadline,
    );
  }

  group('GoTasksRepo - Task CRUD', () {
    test('createTask inserts task and returns domain model', () async {
      final event = buildEvent(createdBy: 'user-123');
      await context.goEventsRepo.createEvent(event);

      final task = buildTask(
        title: 'Buy tickets',
        eventId: event.id,
        createdBy: 'user-123',
      );

      final created = await context.goTasksRepo.createTask(task);

      expect(created.id, task.id);
      expect(created.title, 'Buy tickets');
      expect(created.eventId, event.id);
      expect(created.createdBy, 'user-123');
      expect(created.isDone, isFalse);

      final stored = await context.goTasksRepo.getTaskById(task.id);
      expect(stored, isNotNull);
      expect(stored!.title, 'Buy tickets');
    });

    test('getTaskById returns stored task when found', () async {
      final event = buildEvent();
      await context.goEventsRepo.createEvent(event);

      final task = buildTask(
        title: 'Book hotel',
        eventId: event.id,
      );
      await context.goTasksRepo.createTask(task);

      final result = await context.goTasksRepo.getTaskById(task.id);

      expect(result, isNotNull);
      expect(result!.id, task.id);
      expect(result.title, 'Book hotel');
    });

    test('getTaskById returns null when task does not exist', () async {
      final result = await context.goTasksRepo.getTaskById('missing-id');

      expect(result, isNull);
    });

    test('updateTask modifies existing task', () async {
      final event = buildEvent();
      await context.goEventsRepo.createEvent(event);

      final task = buildTask(
        title: 'Original',
        eventId: event.id,
      );
      await context.goTasksRepo.createTask(task);

      final updated = task.copyWith(
        title: 'Updated',
        isPrivate: false,
      );
      await context.goTasksRepo.updateTask(updated);

      final stored = await context.goTasksRepo.getTaskById(task.id);
      expect(stored, isNotNull);
      expect(stored!.title, 'Updated');
      expect(stored.isPrivate, false);
    });

    test('markTaskDone sets task as completed', () async {
      final event = buildEvent();
      await context.goEventsRepo.createEvent(event);

      final task = buildTask(eventId: event.id);
      await context.goTasksRepo.createTask(task);

      await context.goTasksRepo.markTaskDone(task.id);

      final stored = await context.goTasksRepo.getTaskById(task.id);
      expect(stored, isNotNull);
      expect(stored!.isDone, isTrue);
      expect(stored.completedAt, isNotNull);
    });

    test('deleteTask removes task from database', () async {
      final event = buildEvent();
      await context.goEventsRepo.createEvent(event);

      final task = buildTask(eventId: event.id);
      await context.goTasksRepo.createTask(task);

      await context.goTasksRepo.deleteTask(task.id);

      final stored = await context.goTasksRepo.getTaskById(task.id);
      expect(stored, isNull);
    });

    test('getEventTasks returns all tasks for event', () async {
      final event = buildEvent();
      await context.goEventsRepo.createEvent(event);

      final task1 = buildTask(title: 'Task 1', eventId: event.id);
      final task2 = buildTask(title: 'Task 2', eventId: event.id);

      await context.goTasksRepo.createTask(task1);
      await context.goTasksRepo.createTask(task2);

      final result = await context.goTasksRepo.getEventTasks(event.id);

      expect(result, hasLength(2));
      expect(result.map((t) => t.title), containsAll(['Task 1', 'Task 2']));
    });

    test('getEventTasks returns empty list when no tasks exist', () async {
      final result = await context.goTasksRepo.getEventTasks('event-999');

      expect(result, isEmpty);
    });

    test('getUserTasks returns all tasks for user', () async {
      final event1 = buildEvent(createdBy: 'user-123');
      final event2 = buildEvent(createdBy: 'user-456');
      await context.goEventsRepo.createEvent(event1);
      await context.goEventsRepo.createEvent(event2);

      final task1 = buildTask(
        title: 'User Task 1',
        eventId: event1.id,
        createdBy: 'user-123',
      );
      final task2 = buildTask(
        title: 'User Task 2',
        eventId: event1.id,
        createdBy: 'user-123',
      );
      final task3 = buildTask(
        title: 'Other Task',
        eventId: event2.id,
        createdBy: 'user-456',
      );

      await context.goTasksRepo.createTask(task1);
      await context.goTasksRepo.createTask(task2);
      await context.goTasksRepo.createTask(task3);

      final result = await context.goTasksRepo.getUserTasks('user-123');

      expect(result, hasLength(2));
      expect(
        result.map((t) => t.title),
        containsAll(['User Task 1', 'User Task 2']),
      );
    });

    test('getUserTasks returns empty list when no tasks exist', () async {
      final result = await context.goTasksRepo.getUserTasks('user-999');

      expect(result, isEmpty);
    });

    test('getEventTasks includes both done and not done tasks', () async {
      final event = buildEvent();
      await context.goEventsRepo.createEvent(event);

      final task1 = buildTask(title: 'Done Task', eventId: event.id);
      final task2 = buildTask(title: 'Pending Task', eventId: event.id);

      await context.goTasksRepo.createTask(task1);
      await context.goTasksRepo.createTask(task2);
      await context.goTasksRepo.markTaskDone(task1.id);

      final result = await context.goTasksRepo.getEventTasks(event.id);

      expect(result, hasLength(2));
      expect(result.where((t) => t.isDone), hasLength(1));
      expect(result.where((t) => !t.isDone), hasLength(1));
    });

    test('task can be private or shared', () async {
      final event = buildEvent();
      await context.goEventsRepo.createEvent(event);

      final privateTask = buildTask(
        title: 'Private',
        eventId: event.id,
        isPrivate: true,
      );
      final sharedTask = buildTask(
        title: 'Shared',
        eventId: event.id,
        isPrivate: false,
      );

      await context.goTasksRepo.createTask(privateTask);
      await context.goTasksRepo.createTask(sharedTask);

      final stored1 = await context.goTasksRepo.getTaskById(privateTask.id);
      final stored2 = await context.goTasksRepo.getTaskById(sharedTask.id);

      expect(stored1!.isPrivate, true);
      expect(stored2!.isPrivate, false);
    });

    test('tasks can have optional deadline', () async {
      final event = buildEvent();
      await context.goEventsRepo.createEvent(event);

      final taskWithDeadline = buildTask(
        title: 'With Deadline',
        eventId: event.id,
        deadline: DateTime.utc(2025, 6, 15),
      );
      final taskWithoutDeadline = buildTask(
        title: 'Without Deadline',
        eventId: event.id,
      );

      await context.goTasksRepo.createTask(taskWithDeadline);
      await context.goTasksRepo.createTask(taskWithoutDeadline);

      final stored1 =
          await context.goTasksRepo.getTaskById(taskWithDeadline.id);
      final stored2 =
          await context.goTasksRepo.getTaskById(taskWithoutDeadline.id);

      expect(stored1!.deadline, isNotNull);
      expect(
        stored1.deadline!.year,
        2025,
      );
      expect(
        stored1.deadline!.month,
        6,
      );
      expect(
        stored1.deadline!.day,
        15,
      );
      expect(stored2!.deadline, isNull);
    });
  });
}

class GoTasksRepoTestContext {
  GoTasksRepoTestContext._({
    required this.database,
    required this.goEventsRepo,
    required this.goTasksRepo,
  });

  final Database database;
  final GoEventsRepo goEventsRepo;
  final GoTasksRepo goTasksRepo;

  static Future<GoTasksRepoTestContext> create() async {
    final database = Database(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = OFF');
    final goDao = GoDao(database);

    final goEventsRepo = GoEventsRepo(goDao: goDao);
    final goTasksRepo = GoTasksRepo(goDao: goDao);

    return GoTasksRepoTestContext._(
      database: database,
      goEventsRepo: goEventsRepo,
      goTasksRepo: goTasksRepo,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}
