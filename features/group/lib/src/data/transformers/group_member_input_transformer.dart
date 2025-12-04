import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:group/group_domain.dart';

class GroupMemberInputTransformer {
  static Insertable<GroupMembersTableData> transform(GroupMember member) {
    return GroupMembersTableCompanion.insert(
      id: Value(member.id),
      groupId: member.groupId,
      userId: member.userId,
      role: member.role,
      joinedAt: Value(member.joinedAt),
      isActive: Value(member.isActive),
    );
  }
}
