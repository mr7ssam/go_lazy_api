import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';
import 'package:uuid/uuid.dart';

class GoEventsTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get title => text().customConstraint('NOT NULL')();

  TextColumn? get description => text().nullable()();

  TextColumn? get locationId =>
      text().nullable().references(GoLocationsTable, #id)();

  DateTimeColumn get startDate => dateTime().customConstraint('NOT NULL')();

  DateTimeColumn? get endDate => dateTime().nullable()();

  TextColumn? get groupId => text().nullable().references(GroupsTable, #id)();

  TextColumn? get coverImageUrl => text().nullable()();

  TextColumn get createdBy => text().references(UserTable, #id)();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  DateTimeColumn? get updatedAt => dateTime().nullable()();

  BoolColumn get isActive =>
      boolean().customConstraint('NOT NULL DEFAULT true')();

  TextColumn get visibility =>
      textEnum<GoVisibilityEnum>().withDefault(const Constant('public'))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'go_events';
}
