import 'package:database/database.dart';
import 'package:group/src/domain/entities/group_entity.dart';
import 'package:uuid/uuid.dart';

class GroupMember {
  GroupMember({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    required this.isActive,
  });

  factory GroupMember.create({
    required String groupId,
    required String userId,
    required GroupMemberRoleEnum role,
  }) {
    return GroupMember(
      id: const Uuid().v4(),
      groupId: groupId,
      userId: userId,
      role: role,
      joinedAt: DateTime.now().toUtc(),
      isActive: true,
    );
  }

  final String id;
  final String groupId;
  final String userId;
  final GroupMemberRoleEnum role;
  final DateTime joinedAt;
  final bool isActive;

  GroupMember copyWith({
    String? id,
    String? groupId,
    String? userId,
    GroupMemberRoleEnum? role,
    DateTime? joinedAt,
    bool? isActive,
  }) {
    return GroupMember(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

class GroupMemberUser {
  GroupMemberUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.photoUrl,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? photoUrl;
}

class GroupMemberWithUser {
  GroupMemberWithUser({
    required this.member,
    required this.user,
  });

  final GroupMember member;
  final GroupMemberUser user;
}

class GroupWithMembers {
  GroupWithMembers({
    required this.group,
    required this.members,
  });

  final Group group;
  final List<GroupMemberWithUser> members;

  int get memberCount => members.where((m) => m.member.isActive).length;

  GroupMemberUser? get owner => members
      .where(
        (m) => m.member.role == GroupMemberRoleEnum.owner && m.member.isActive,
      )
      .map((m) => m.user)
      .firstOrNull;
}
