import 'package:database/database.dart';
import 'package:group/src/domain/entities/index.dart';

abstract class IGroupsRepo {
  // Group CRUD
  Future<Group> createGroup(Group group);
  Future<void> updateGroup(Group group);
  Future<Group?> getGroupById(String id);
  Future<List<Group>> getUserGroups(String userId);
  Future<void> deleteGroup(String id);

  // Membership
  Future<GroupMember> addMember(GroupMember member);
  Future<void> updateMemberRole(String memberId, GroupMemberRoleEnum newRole);
  Future<void> removeMember(String memberId);
  Future<GroupMember?> getMembership(String groupId, String userId);
  Future<List<GroupMemberWithUser>> getGroupMembers(String groupId);

  // Authorization
  Future<bool> isGroupMember(String groupId, String userId);
  Future<bool> hasRole(
    String groupId,
    String userId,
    List<GroupMemberRoleEnum> roles,
  );
}
