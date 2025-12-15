import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@TableIndex(name: 'idx_go_tasks_event_privacy', columns: {#eventId, #isPrivate})
class GoTasksTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get eventId => text().references(GoEventsTable, #id)();

  TextColumn get title => text().customConstraint('NOT NULL')();

  TextColumn? get description => text().nullable()();

  DateTimeColumn? get deadline => dateTime().nullable()();

  TextColumn get createdBy => text().references(UserTable, #id)();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  DateTimeColumn? get completedAt => dateTime().nullable()();

  DateTimeColumn? get updatedAt => dateTime().nullable()();

  BoolColumn get isDone =>
      boolean().customConstraint('NOT NULL DEFAULT false')();

  BoolColumn get isPrivate =>
      boolean().customConstraint('NOT NULL DEFAULT false')();

  TextColumn? get completedBy => text().nullable().references(UserTable, #id)();

  TextColumn? get updatedBy => text().nullable().references(UserTable, #id)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'go_tasks';
}
