import 'package:database/src/tables/index.dart' show GroupsTable, UserTable;
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

enum GroupMemberRoleEnum {
  owner,
  admin,
  member,
}

class GroupMembersTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get groupId => text().references(GroupsTable, #id)();

  TextColumn get userId => text().references(UserTable, #id)();

  TextColumn get role => textEnum<GroupMemberRoleEnum>()();

  DateTimeColumn get joinedAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  BoolColumn get isActive =>
      boolean().customConstraint('NOT NULL DEFAULT true')();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {groupId, userId},
      ];

  @override
  String get tableName => 'group_members';
}
