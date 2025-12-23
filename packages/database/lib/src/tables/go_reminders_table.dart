import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';
import 'package:uuid/uuid.dart';

@TableIndex(name: 'idx_go_reminders_task', columns: {#taskId})
@TableIndex(name: 'idx_go_reminders_user', columns: {#userId})
@TableIndex(name: 'idx_go_reminders_remind_at', columns: {#remindAt})
class GoRemindersTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get taskId => text().references(GoTasksTable, #id)();

  TextColumn get userId => text().references(UserTable, #id)();

  TextColumn get reminderType => textEnum<GoReminderType>()();

  DateTimeColumn? get remindAt => dateTime().nullable()();

  IntColumn? get minutesBefore => integer().nullable()();

  BoolColumn get isSent =>
      boolean().customConstraint('NOT NULL DEFAULT false')();

  DateTimeColumn? get sentAt => dateTime().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'go_reminders';
}
