import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:group/group_domain.dart';
import 'package:group/src/data/transformers/index.dart';

class GroupsRepo implements IGroupsRepo {
  GroupsRepo({
    required GroupsDao groupsDao,
    required UsersDao usersDao,
  })  : _groupsDao = groupsDao,
        _usersDao = usersDao;

  final GroupsDao _groupsDao;
  final UsersDao _usersDao;

  @override
  Future<Group> createGroup(Group group) async {
    final companion = GroupInputTransformer.transform(group);
    final result = await _groupsDao
        .into(_groupsDao.groupsTable)
        .insertReturning(companion);

    return GroupOutputTransformer.transform(result);
  }

  @override
  Future<void> updateGroup(Group group) async {
    final companion = GroupInputTransformer.transform(group);

    await (_groupsDao.update(_groupsDao.groupsTable)
          ..where((tbl) => tbl.id.equals(group.id)))
        .write(companion);
  }

  @override
  Future<Group?> getGroupById(String id) async {
    final query = _groupsDao.select(_groupsDao.groupsTable)
      ..where((tbl) => tbl.id.equals(id) & tbl.isActive.equals(true));
    final result = await query.getSingleOrNull();

    return result != null ? GroupOutputTransformer.transform(result) : null;
  }

  @override
  Future<List<Group>> getUserGroups(String userId) async {
    final query = _groupsDao.select(_groupsDao.groupsTable).join([
      innerJoin(
        _groupsDao.groupMembersTable,
        _groupsDao.groupMembersTable.groupId.equalsExp(
          _groupsDao.groupsTable.id,
        ),
      ),
    ])
      ..where(
        _groupsDao.groupMembersTable.userId.equals(userId) &
            _groupsDao.groupMembersTable.isActive.equals(true) &
            _groupsDao.groupsTable.isActive.equals(true),
      );

    final results = await query.get();

    return results
        .map(
          (row) => GroupOutputTransformer.transform(
            row.readTable(_groupsDao.groupsTable),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteGroup(String id) async {
    await (_groupsDao.update(_groupsDao.groupsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(const GroupsTableCompanion(isActive: Value(false)));
  }

  @override
  Future<GroupMember> addMember(GroupMember member) async {
    final companion = GroupMemberInputTransformer.transform(member);
    final result = await _groupsDao
        .into(_groupsDao.groupMembersTable)
        .insertReturning(companion);

    return GroupMemberOutputTransformer.transform(result);
  }

  @override
  Future<void> updateMemberRole(
    String memberId,
    GroupMemberRoleEnum newRole,
  ) async {
    await (_groupsDao.update(_groupsDao.groupMembersTable)
          ..where((tbl) => tbl.id.equals(memberId)))
        .write(GroupMembersTableCompanion(role: Value(newRole)));
  }

  @override
  Future<void> removeMember(String memberId) async {
    await (_groupsDao.update(_groupsDao.groupMembersTable)
          ..where((tbl) => tbl.id.equals(memberId)))
        .write(const GroupMembersTableCompanion(isActive: Value(false)));
  }

  @override
  Future<GroupMember?> getMembership(String groupId, String userId) async {
    final query = _groupsDao.select(_groupsDao.groupMembersTable)
      ..where(
        (tbl) =>
            tbl.groupId.equals(groupId) &
            tbl.userId.equals(userId) &
            tbl.isActive.equals(true),
      );
    final result = await query.getSingleOrNull();

    return result != null
        ? GroupMemberOutputTransformer.transform(result)
        : null;
  }

  @override
  Future<List<GroupMemberWithUser>> getGroupMembers(String groupId) async {
    final query = _groupsDao.select(_groupsDao.groupMembersTable).join([
      innerJoin(
        _usersDao.userTable,
        _usersDao.userTable.id.equalsExp(_groupsDao.groupMembersTable.userId),
      ),
    ])
      ..where(
        _groupsDao.groupMembersTable.groupId.equals(groupId) &
            _groupsDao.groupMembersTable.isActive.equals(true),
      );

    final results = await query.get();

    return results.map((row) {
      final memberData = row.readTable(_groupsDao.groupMembersTable);
      final userData = row.readTable(_usersDao.userTable);

      return GroupMemberWithUser(
        member: GroupMemberOutputTransformer.transform(memberData),
        user: GroupMemberUser(
          id: userData.id,
          firstName: userData.firstName,
          lastName: userData.lastName,
          email: userData.email,
          phoneNumber: userData.phoneNumber,
          photoUrl: userData.photoUrl,
        ),
      );
    }).toList();
  }

  @override
  Future<bool> isGroupMember(String groupId, String userId) async {
    final member = await getMembership(groupId, userId);

    return member != null;
  }

  @override
  Future<bool> hasRole(
    String groupId,
    String userId,
    List<GroupMemberRoleEnum> roles,
  ) async {
    final member = await getMembership(groupId, userId);
    if (member == null) return false;
    return roles.contains(member.role);
  }
}
