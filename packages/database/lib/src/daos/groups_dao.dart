import 'package:dart_frog/dart_frog.dart';
import 'package:database/src/database.dart';
import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';

part 'groups_dao.g.dart';

@DriftAccessor(tables: [GroupsTable, GroupMembersTable, GroupInvitesTable])
class GroupsDao extends DatabaseAccessor<Database> with _$GroupsDaoMixin {
  GroupsDao(super.attachedDatabase);

  static GroupsDao? _dao;

  static Middleware middlewareProvider() {
    return provider<GroupsDao>(
      (context) => _dao ??= GroupsDao(context.read<Database>()),
    );
  }
}
