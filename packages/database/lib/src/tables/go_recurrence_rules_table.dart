import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class GoRecurrenceRulesTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get eventId =>
      text().references(GoEventsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get frequency => text().customConstraint('NOT NULL')();

  IntColumn get interval =>
      integer().customConstraint('NOT NULL DEFAULT 1')();

  TextColumn? get daysOfWeek => text().nullable()();

  IntColumn? get dayOfMonth => integer().nullable()();

  IntColumn? get weekOfMonth => integer().nullable()();

  TextColumn? get dayOfWeekInMonth => text().nullable()();

  TextColumn get endType => text().customConstraint('NOT NULL')();

  IntColumn? get endAfterCount => integer().nullable()();

  DateTimeColumn? get endUntilDate => dateTime().nullable()();

  TextColumn get taskMode => text().customConstraint('NOT NULL DEFAULT \'copy\'')();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  DateTimeColumn? get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'go_recurrence_rules';
}
