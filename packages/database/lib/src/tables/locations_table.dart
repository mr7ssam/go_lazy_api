import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';

class LocationTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get userId => text().nullable().references(
        UserTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get groupId => text().nullable().references(
        GroupsTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get name => text().withLength(min: 1, max: 100)();

  TextColumn get address => text().withLength(min: 1, max: 500)();

  RealColumn get latitude => real()();

  RealColumn get longitude => real()();

  TextColumn get category => text().nullable().withLength(max: 50)();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  TextColumn get notes => text().nullable().withLength(max: 500)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, name},
        {groupId, name},
      ];

  @override
  List<String> get customConstraints => [
        '''
CHECK((user_id IS NOT NULL AND group_id IS NULL) OR (user_id IS NULL AND group_id IS NOT NULL))''',
      ];

  @override
  String get tableName => 'locations';
}
