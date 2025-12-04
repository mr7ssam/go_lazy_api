import 'package:database/database.dart';
import 'package:group/group_domain.dart';

class GroupMemberOutputTransformer {
  static GroupMember transform(GroupMembersTableData data) {
    return GroupMember(
      id: data.id,
      groupId: data.groupId,
      userId: data.userId,
      role: data.role,
      joinedAt: data.joinedAt,
      isActive: data.isActive,
    );
  }
}
