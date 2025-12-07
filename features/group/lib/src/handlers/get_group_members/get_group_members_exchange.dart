import 'package:database/database.dart';

class GetGroupMembersRequest {
  const GetGroupMembersRequest({
    required this.groupId,
    required this.userId,
  });

  final String groupId;
  final String userId;

  GetGroupMembersRequest copyWith({
    String? groupId,
    String? userId,
  }) {
    return GetGroupMembersRequest(
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
    );
  }
}

class MemberInfo {
  const MemberInfo({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.joinedAt,
    this.photoUrl,
  });

  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final GroupMemberRoleEnum role;
  final DateTime joinedAt;
  final String? photoUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'role': role.name,
        'joinedAt': joinedAt.toIso8601String(),
        'photoUrl': photoUrl,
      };
}

class GetGroupMembersResponse {
  const GetGroupMembersResponse({
    required this.members,
  });

  final List<MemberInfo> members;

  Map<String, dynamic> toJson() => {
        'members': members.map((m) => m.toJson()).toList(),
      };
}
