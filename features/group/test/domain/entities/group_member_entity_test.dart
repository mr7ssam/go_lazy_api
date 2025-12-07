import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:test/test.dart';

void main() {
  group('GroupMember', () {
    test('create factory generates valid GroupMember', () {
      final member = GroupMember.create(
        groupId: 'group-123',
        userId: 'user-456',
        role: GroupMemberRoleEnum.member,
      );

      expect(member.id, isNotEmpty);
      expect(member.groupId, equals('group-123'));
      expect(member.userId, equals('user-456'));
      expect(member.role, equals(GroupMemberRoleEnum.member));
      expect(member.joinedAt, isNotNull);
      expect(member.isActive, isTrue);
    });

    test('create factory generates unique ids', () {
      final member1 = GroupMember.create(
        groupId: 'group-123',
        userId: 'user-456',
        role: GroupMemberRoleEnum.member,
      );
      final member2 = GroupMember.create(
        groupId: 'group-123',
        userId: 'user-789',
        role: GroupMemberRoleEnum.member,
      );

      expect(member1.id, isNot(equals(member2.id)));
    });

    test('create factory with owner role', () {
      final member = GroupMember.create(
        groupId: 'group-123',
        userId: 'user-456',
        role: GroupMemberRoleEnum.owner,
      );

      expect(member.role, equals(GroupMemberRoleEnum.owner));
    });

    test('create factory with admin role', () {
      final member = GroupMember.create(
        groupId: 'group-123',
        userId: 'user-456',
        role: GroupMemberRoleEnum.admin,
      );

      expect(member.role, equals(GroupMemberRoleEnum.admin));
    });

    test('copyWith updates specified fields', () {
      final original = GroupMember(
        id: 'member-id',
        groupId: 'group-123',
        userId: 'user-456',
        role: GroupMemberRoleEnum.member,
        joinedAt: DateTime.utc(2025),
        isActive: true,
      );

      final copied = original.copyWith(
        role: GroupMemberRoleEnum.admin,
        isActive: false,
      );

      expect(copied.id, equals(original.id));
      expect(copied.groupId, equals(original.groupId));
      expect(copied.userId, equals(original.userId));
      expect(copied.role, equals(GroupMemberRoleEnum.admin));
      expect(copied.joinedAt, equals(original.joinedAt));
      expect(copied.isActive, isFalse);
    });

    test('copyWith preserves all fields when none specified', () {
      final original = GroupMember(
        id: 'member-id',
        groupId: 'group-123',
        userId: 'user-456',
        role: GroupMemberRoleEnum.owner,
        joinedAt: DateTime.utc(2025),
        isActive: true,
      );

      final copied = original.copyWith();

      expect(copied.id, equals(original.id));
      expect(copied.groupId, equals(original.groupId));
      expect(copied.userId, equals(original.userId));
      expect(copied.role, equals(original.role));
      expect(copied.joinedAt, equals(original.joinedAt));
      expect(copied.isActive, equals(original.isActive));
    });
  });

  group('GroupMemberUser', () {
    test('creates with all required fields', () {
      final memberUser = GroupMemberUser(
        id: 'user-123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
      );

      expect(memberUser.id, equals('user-123'));
      expect(memberUser.firstName, equals('John'));
      expect(memberUser.lastName, equals('Doe'));
      expect(memberUser.email, equals('john@example.com'));
      expect(memberUser.phoneNumber, equals('+1234567890'));
      expect(memberUser.photoUrl, isNull);
    });

    test('creates with optional photoUrl', () {
      final memberUser = GroupMemberUser(
        id: 'user-123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        photoUrl: 'https://example.com/photo.png',
      );

      expect(memberUser.photoUrl, equals('https://example.com/photo.png'));
    });
  });

  group('GroupMemberWithUser', () {
    test('creates with member and user', () {
      final member = GroupMember(
        id: 'member-id',
        groupId: 'group-123',
        userId: 'user-456',
        role: GroupMemberRoleEnum.admin,
        joinedAt: DateTime.utc(2025),
        isActive: true,
      );
      final user = GroupMemberUser(
        id: 'user-456',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
      );

      final memberWithUser = GroupMemberWithUser(
        member: member,
        user: user,
      );

      expect(memberWithUser.member, equals(member));
      expect(memberWithUser.user, equals(user));
      expect(memberWithUser.member.role, equals(GroupMemberRoleEnum.admin));
    });
  });

  group('GroupWithMembers', () {
    test('memberCount returns count of active members', () {
      final group = Group(
        id: 'group-id',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025),
        isActive: true,
      );

      final members = [
        GroupMemberWithUser(
          member: GroupMember(
            id: 'member-1',
            groupId: 'group-id',
            userId: 'user-1',
            role: GroupMemberRoleEnum.owner,
            joinedAt: DateTime.utc(2025),
            isActive: true,
          ),
          user: GroupMemberUser(
            id: 'user-1',
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            phoneNumber: '+1111111111',
          ),
        ),
        GroupMemberWithUser(
          member: GroupMember(
            id: 'member-2',
            groupId: 'group-id',
            userId: 'user-2',
            role: GroupMemberRoleEnum.member,
            joinedAt: DateTime.utc(2025, 1, 2),
            isActive: true,
          ),
          user: GroupMemberUser(
            id: 'user-2',
            firstName: 'Jane',
            lastName: 'Smith',
            email: 'jane@example.com',
            phoneNumber: '+2222222222',
          ),
        ),
        GroupMemberWithUser(
          member: GroupMember(
            id: 'member-3',
            groupId: 'group-id',
            userId: 'user-3',
            role: GroupMemberRoleEnum.member,
            joinedAt: DateTime.utc(2025, 1, 3),
            isActive: false, // Inactive member
          ),
          user: GroupMemberUser(
            id: 'user-3',
            firstName: 'Bob',
            lastName: 'Wilson',
            email: 'bob@example.com',
            phoneNumber: '+3333333333',
          ),
        ),
      ];

      final groupWithMembers = GroupWithMembers(
        group: group,
        members: members,
      );

      expect(groupWithMembers.memberCount, equals(2)); // Only active members
    });

    test('owner returns the owner user when exists', () {
      final group = Group(
        id: 'group-id',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025),
        isActive: true,
      );

      final ownerUser = GroupMemberUser(
        id: 'user-1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phoneNumber: '+1111111111',
      );

      final members = [
        GroupMemberWithUser(
          member: GroupMember(
            id: 'member-1',
            groupId: 'group-id',
            userId: 'user-1',
            role: GroupMemberRoleEnum.owner,
            joinedAt: DateTime.utc(2025),
            isActive: true,
          ),
          user: ownerUser,
        ),
        GroupMemberWithUser(
          member: GroupMember(
            id: 'member-2',
            groupId: 'group-id',
            userId: 'user-2',
            role: GroupMemberRoleEnum.member,
            joinedAt: DateTime.utc(2025, 1, 2),
            isActive: true,
          ),
          user: GroupMemberUser(
            id: 'user-2',
            firstName: 'Jane',
            lastName: 'Smith',
            email: 'jane@example.com',
            phoneNumber: '+2222222222',
          ),
        ),
      ];

      final groupWithMembers = GroupWithMembers(
        group: group,
        members: members,
      );

      expect(groupWithMembers.owner, equals(ownerUser));
    });

    test('owner returns null when no active owner exists', () {
      final group = Group(
        id: 'group-id',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025),
        isActive: true,
      );

      final members = [
        GroupMemberWithUser(
          member: GroupMember(
            id: 'member-1',
            groupId: 'group-id',
            userId: 'user-1',
            role: GroupMemberRoleEnum.owner,
            joinedAt: DateTime.utc(2025),
            isActive: false, // Inactive owner
          ),
          user: GroupMemberUser(
            id: 'user-1',
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            phoneNumber: '+1111111111',
          ),
        ),
      ];

      final groupWithMembers = GroupWithMembers(
        group: group,
        members: members,
      );

      expect(groupWithMembers.owner, isNull);
    });

    test('owner returns null when group has no owner role', () {
      final group = Group(
        id: 'group-id',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025),
        isActive: true,
      );

      final members = [
        GroupMemberWithUser(
          member: GroupMember(
            id: 'member-1',
            groupId: 'group-id',
            userId: 'user-1',
            role: GroupMemberRoleEnum.admin,
            joinedAt: DateTime.utc(2025),
            isActive: true,
          ),
          user: GroupMemberUser(
            id: 'user-1',
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            phoneNumber: '+1111111111',
          ),
        ),
      ];

      final groupWithMembers = GroupWithMembers(
        group: group,
        members: members,
      );

      expect(groupWithMembers.owner, isNull);
    });
  });
}
