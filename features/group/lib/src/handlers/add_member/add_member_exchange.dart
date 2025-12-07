import 'package:database/database.dart';

class AddMemberRequest {
  const AddMemberRequest({
    required this.groupId,
    required this.requestingUserId,
    required this.targetUserId,
    this.role = GroupMemberRoleEnum.member,
  });

  factory AddMemberRequest.fromJson(Map<String, dynamic> json) =>
      AddMemberRequest(
        groupId: json['groupId'] as String,
        requestingUserId: json['requestingUserId'] as String,
        targetUserId: json['targetUserId'] as String,
        role: json['role'] != null
            ? GroupMemberRoleEnum.values.firstWhere(
                (e) => e.name == json['role'],
                orElse: () => GroupMemberRoleEnum.member,
              )
            : GroupMemberRoleEnum.member,
      );

  final String groupId;
  final String requestingUserId;
  final String targetUserId;
  final GroupMemberRoleEnum role;

  AddMemberRequest copyWith({
    String? groupId,
    String? requestingUserId,
    String? targetUserId,
    GroupMemberRoleEnum? role,
  }) {
    return AddMemberRequest(
      groupId: groupId ?? this.groupId,
      requestingUserId: requestingUserId ?? this.requestingUserId,
      targetUserId: targetUserId ?? this.targetUserId,
      role: role ?? this.role,
    );
  }
}

class AddMemberResponse {
  const AddMemberResponse({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.role,
    required this.joinedAt,
  });

  final String id;
  final String groupId;
  final String userId;
  final GroupMemberRoleEnum role;
  final DateTime joinedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'userId': userId,
        'role': role.name,
        'joinedAt': joinedAt.toIso8601String(),
      };
}
