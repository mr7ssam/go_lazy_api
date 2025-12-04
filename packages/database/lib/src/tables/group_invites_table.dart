import 'package:database/src/tables/index.dart' show GroupsTable, UserTable;
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

enum InviteStatusEnum {
  pending,
  accepted,
  rejected,
}

class GroupInvitesTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get groupId => text().references(GroupsTable, #id)();

  TextColumn get invitedBy => text().references(UserTable, #id)();

  TextColumn get invitedUserId => text().references(UserTable, #id)();

  TextColumn get status => textEnum<InviteStatusEnum>()();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'group_invites';
}
