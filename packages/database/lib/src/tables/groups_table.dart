import 'package:database/src/tables/index.dart' show UserTable;
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class GroupsTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get name => text().customConstraint('NOT NULL')();

  TextColumn? get description => text().nullable()();

  TextColumn? get imageUrl => text().nullable()();

  TextColumn get createdBy => text().references(UserTable, #id)();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  DateTimeColumn? get updatedAt => dateTime().nullable()();

  BoolColumn get isActive =>
      boolean().customConstraint('NOT NULL DEFAULT true')();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'groups';
}
