import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class GoLocationsTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get name => text().customConstraint('NOT NULL')();

  TextColumn? get address => text().nullable()();

  RealColumn? get latitude => real().nullable()();

  RealColumn? get longitude => real().nullable()();

  TextColumn? get googleMapsUrl => text().nullable()();

  TextColumn get createdBy => text().references(UserTable, #id)();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  DateTimeColumn? get updatedAt => dateTime().nullable()();

  BoolColumn get isActive =>
      boolean().customConstraint('NOT NULL DEFAULT true')();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'go_locations';
}
