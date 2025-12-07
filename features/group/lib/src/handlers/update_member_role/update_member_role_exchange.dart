import 'package:database/database.dart';

class UpdateMemberRoleRequest {
  const UpdateMemberRoleRequest({
    required this.groupId,
    required this.requestingUserId,
    required this.targetUserId,
    required this.newRole,
  });

  factory UpdateMemberRoleRequest.fromJson(Map<String, dynamic> json) =>
      UpdateMemberRoleRequest(
        groupId: json['groupId'] as String,
        requestingUserId: json['requestingUserId'] as String,
        targetUserId: json['targetUserId'] as String,
        newRole: GroupMemberRoleEnum.values.firstWhere(
          (e) => e.name == json['role'],
        ),
      );

  final String groupId;
  final String requestingUserId;
  final String targetUserId;
  final GroupMemberRoleEnum newRole;

  UpdateMemberRoleRequest copyWith({
    String? groupId,
    String? requestingUserId,
    String? targetUserId,
    GroupMemberRoleEnum? newRole,
  }) {
    return UpdateMemberRoleRequest(
      groupId: groupId ?? this.groupId,
      requestingUserId: requestingUserId ?? this.requestingUserId,
      targetUserId: targetUserId ?? this.targetUserId,
      newRole: newRole ?? this.newRole,
    );
  }
}

class UpdateMemberRoleResponse {
  const UpdateMemberRoleResponse({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.role,
  });

  final String id;
  final String groupId;
  final String userId;
  final GroupMemberRoleEnum role;

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'userId': userId,
        'role': role.name,
      };
}
