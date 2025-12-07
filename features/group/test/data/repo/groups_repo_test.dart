import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:group/group_data.dart';
import 'package:group/group_domain.dart';
import 'package:test/test.dart';
import 'package:user/user_data.dart';
import 'package:user/user_domain.dart';

void main() {
  late GroupsRepoTestContext context;

  setUp(() async {
    context = await GroupsRepoTestContext.create();
  });

  tearDown(() async {
    await context.dispose();
  });

  User buildUser({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
  }) {
    return User.create(
      firstName: firstName ?? 'John',
      lastName: lastName ?? 'Doe',
      email: email ?? 'john.doe@example.com',
      phoneNumber: phoneNumber ?? '+1234567890',
    );
  }

  Group buildGroup({
    String? name,
    String? createdBy,
    String? description,
    String? imageUrl,
  }) {
    return Group.create(
      name: name ?? 'Test Group',
      createdBy: createdBy ?? 'user-123',
      description: description,
      imageUrl: imageUrl,
    );
  }

  group('GroupsRepo - Group CRUD', () {
    test('createGroup inserts a group and returns domain model', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      final created = await context.groupsRepo.createGroup(group);

      expect(created.id, group.id);
      expect(created.name, group.name);
      expect(created.createdBy, user.id);
      expect(created.isActive, isTrue);

      final stored = await context.groupsRepo.getGroupById(group.id);
      expect(stored, isNotNull);
      expect(stored!.name, group.name);
    });

    test('getGroupById returns the stored group when found', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(
        name: 'Lookup Group',
        createdBy: user.id,
        description: 'A group to look up',
      );
      await context.groupsRepo.createGroup(group);

      final result = await context.groupsRepo.getGroupById(group.id);

      expect(result, isNotNull);
      expect(result!.id, group.id);
      expect(result.name, 'Lookup Group');
      expect(result.description, 'A group to look up');
    });

    test('getGroupById returns null when group does not exist', () async {
      final result = await context.groupsRepo.getGroupById('missing-id');

      expect(result, isNull);
    });

    test('getGroupById returns null for deleted groups', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);
      await context.groupsRepo.deleteGroup(group.id);

      final result = await context.groupsRepo.getGroupById(group.id);

      expect(result, isNull);
    });

    test('updateGroup updates an existing group', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      final created = await context.groupsRepo.createGroup(group);

      final updated = created.copyWith(
        name: 'Updated Group Name',
        description: 'Updated description',
      );

      await context.groupsRepo.updateGroup(updated);

      final stored = await context.groupsRepo.getGroupById(created.id);

      expect(stored, isNotNull);
      expect(stored!.name, 'Updated Group Name');
      expect(stored.description, 'Updated description');
    });

    test('deleteGroup soft deletes the group', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      await context.groupsRepo.deleteGroup(group.id);

      final result = await context.groupsRepo.getGroupById(group.id);

      expect(result, isNull);
    });

    test('getUserGroups returns groups for a user', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group1 = buildGroup(name: 'Group 1', createdBy: user.id);
      final group2 = buildGroup(name: 'Group 2', createdBy: user.id);
      await context.groupsRepo.createGroup(group1);
      await context.groupsRepo.createGroup(group2);

      // Add user as member to both groups
      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group1.id,
          userId: user.id,
          role: GroupMemberRoleEnum.owner,
        ),
      );
      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group2.id,
          userId: user.id,
          role: GroupMemberRoleEnum.owner,
        ),
      );

      final groups = await context.groupsRepo.getUserGroups(user.id);

      expect(groups.length, 2);
      expect(groups.map((g) => g.name), containsAll(['Group 1', 'Group 2']));
    });

    test('getUserGroups excludes deleted groups', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group1 = buildGroup(name: 'Active Group', createdBy: user.id);
      final group2 = buildGroup(name: 'Deleted Group', createdBy: user.id);
      await context.groupsRepo.createGroup(group1);
      await context.groupsRepo.createGroup(group2);

      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group1.id,
          userId: user.id,
          role: GroupMemberRoleEnum.owner,
        ),
      );
      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group2.id,
          userId: user.id,
          role: GroupMemberRoleEnum.owner,
        ),
      );

      await context.groupsRepo.deleteGroup(group2.id);

      final groups = await context.groupsRepo.getUserGroups(user.id);

      expect(groups.length, 1);
      expect(groups.first.name, 'Active Group');
    });

    test('getUserGroups returns empty list for user with no groups', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final groups = await context.groupsRepo.getUserGroups(user.id);

      expect(groups, isEmpty);
    });
  });

  group('GroupsRepo - Membership', () {
    test('addMember inserts a member and returns domain model', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      final member = GroupMember.create(
        groupId: group.id,
        userId: user.id,
        role: GroupMemberRoleEnum.owner,
      );

      final created = await context.groupsRepo.addMember(member);

      expect(created.id, member.id);
      expect(created.groupId, group.id);
      expect(created.userId, user.id);
      expect(created.role, GroupMemberRoleEnum.owner);
      expect(created.isActive, isTrue);
    });

    test('getMembership returns the stored membership when found', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      final member = GroupMember.create(
        groupId: group.id,
        userId: user.id,
        role: GroupMemberRoleEnum.admin,
      );
      await context.groupsRepo.addMember(member);

      final result = await context.groupsRepo.getMembership(group.id, user.id);

      expect(result, isNotNull);
      expect(result!.id, member.id);
      expect(result.role, GroupMemberRoleEnum.admin);
    });

    test('getMembership returns null when not a member', () async {
      final result =
          await context.groupsRepo.getMembership('group-id', 'user-id');

      expect(result, isNull);
    });

    test('getMembership returns null for removed members', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      final member = GroupMember.create(
        groupId: group.id,
        userId: user.id,
        role: GroupMemberRoleEnum.member,
      );
      final created = await context.groupsRepo.addMember(member);
      await context.groupsRepo.removeMember(created.id);

      final result = await context.groupsRepo.getMembership(group.id, user.id);

      expect(result, isNull);
    });

    test('updateMemberRole changes the member role', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      final member = GroupMember.create(
        groupId: group.id,
        userId: user.id,
        role: GroupMemberRoleEnum.member,
      );
      final created = await context.groupsRepo.addMember(member);

      await context.groupsRepo.updateMemberRole(
        created.id,
        GroupMemberRoleEnum.admin,
      );

      final result = await context.groupsRepo.getMembership(group.id, user.id);

      expect(result, isNotNull);
      expect(result!.role, GroupMemberRoleEnum.admin);
    });

    test('removeMember soft deletes the membership', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      final member = GroupMember.create(
        groupId: group.id,
        userId: user.id,
        role: GroupMemberRoleEnum.member,
      );
      final created = await context.groupsRepo.addMember(member);

      await context.groupsRepo.removeMember(created.id);

      final result = await context.groupsRepo.getMembership(group.id, user.id);

      expect(result, isNull);
    });

    test('getGroupMembers returns all active members with user info', () async {
      final user1 = buildUser(
        email: 'user1@example.com',
        phoneNumber: '+1111111111',
      );
      final user2 = buildUser(
        email: 'user2@example.com',
        firstName: 'Jane',
        lastName: 'Smith',
        phoneNumber: '+2222222222',
      );
      await context.usersRepo.createUser(user1);
      await context.usersRepo.createUser(user2);

      final group = buildGroup(createdBy: user1.id);
      await context.groupsRepo.createGroup(group);

      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group.id,
          userId: user1.id,
          role: GroupMemberRoleEnum.owner,
        ),
      );
      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group.id,
          userId: user2.id,
          role: GroupMemberRoleEnum.member,
        ),
      );

      final members = await context.groupsRepo.getGroupMembers(group.id);

      expect(members.length, 2);

      final ownerMember = members.firstWhere(
        (m) => m.member.role == GroupMemberRoleEnum.owner,
      );
      expect(ownerMember.user.firstName, 'John');
      expect(ownerMember.user.email, 'user1@example.com');

      final regularMember = members.firstWhere(
        (m) => m.member.role == GroupMemberRoleEnum.member,
      );
      expect(regularMember.user.firstName, 'Jane');
      expect(regularMember.user.email, 'user2@example.com');
    });

    test('getGroupMembers excludes inactive members', () async {
      final user1 = buildUser(
        email: 'active@example.com',
        phoneNumber: '+3333333333',
      );
      final user2 = buildUser(
        email: 'removed@example.com',
        phoneNumber: '+4444444444',
      );
      await context.usersRepo.createUser(user1);
      await context.usersRepo.createUser(user2);

      final group = buildGroup(createdBy: user1.id);
      await context.groupsRepo.createGroup(group);

      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group.id,
          userId: user1.id,
          role: GroupMemberRoleEnum.owner,
        ),
      );
      final removedMember = await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group.id,
          userId: user2.id,
          role: GroupMemberRoleEnum.member,
        ),
      );

      await context.groupsRepo.removeMember(removedMember.id);

      final members = await context.groupsRepo.getGroupMembers(group.id);

      expect(members.length, 1);
      expect(members.first.user.email, 'active@example.com');
    });
  });

  group('GroupsRepo - Authorization', () {
    test('isGroupMember returns true when user is a member', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group.id,
          userId: user.id,
          role: GroupMemberRoleEnum.member,
        ),
      );

      final result = await context.groupsRepo.isGroupMember(group.id, user.id);

      expect(result, isTrue);
    });

    test('isGroupMember returns false when user is not a member', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      final result = await context.groupsRepo.isGroupMember(group.id, user.id);

      expect(result, isFalse);
    });

    test('isGroupMember returns false for removed members', () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      final member = await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group.id,
          userId: user.id,
          role: GroupMemberRoleEnum.member,
        ),
      );
      await context.groupsRepo.removeMember(member.id);

      final result = await context.groupsRepo.isGroupMember(group.id, user.id);

      expect(result, isFalse);
    });

    test('hasRole returns true when user has one of the specified roles',
        () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group.id,
          userId: user.id,
          role: GroupMemberRoleEnum.admin,
        ),
      );

      final result = await context.groupsRepo.hasRole(
        group.id,
        user.id,
        [GroupMemberRoleEnum.owner, GroupMemberRoleEnum.admin],
      );

      expect(result, isTrue);
    });

    test('hasRole returns false when user does not have required role',
        () async {
      final user = buildUser();
      await context.usersRepo.createUser(user);

      final group = buildGroup(createdBy: user.id);
      await context.groupsRepo.createGroup(group);

      await context.groupsRepo.addMember(
        GroupMember.create(
          groupId: group.id,
          userId: user.id,
          role: GroupMemberRoleEnum.member,
        ),
      );

      final result = await context.groupsRepo.hasRole(
        group.id,
        user.id,
        [GroupMemberRoleEnum.owner, GroupMemberRoleEnum.admin],
      );

      expect(result, isFalse);
    });

    test('hasRole returns false when user is not a member', () async {
      final result = await context.groupsRepo.hasRole(
        'group-id',
        'user-id',
        [GroupMemberRoleEnum.owner],
      );

      expect(result, isFalse);
    });
  });
}

class GroupsRepoTestContext {
  GroupsRepoTestContext._({
    required this.database,
    required this.groupsRepo,
    required this.usersRepo,
  });

  final Database database;
  final GroupsRepo groupsRepo;
  final IUsersRepo usersRepo;

  static Future<GroupsRepoTestContext> create() async {
    final database = Database(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = ON');

    final groupsDao = GroupsDao(database);
    final usersDao = UsersDao(database);

    final groupsRepo = GroupsRepo(
      groupsDao: groupsDao,
      usersDao: usersDao,
    );

    final jwtService = JwtService(
      accessTokenSecret: 'access-secret',
      refreshTokenSecret: 'refresh-secret',
    );

    final usersRepo = UsersRepo(
      usersDao: usersDao,
      jwtService: jwtService,
      userOutputTransformer: UserOutputTransformer(),
      userInputTransformer: UserInputTransformer(),
      userOtpInputTransformer: UserOtpInputTransformer(),
      userOtpOutputTransformer: UserOtpOutputTransformer(),
    );

    return GroupsRepoTestContext._(
      database: database,
      groupsRepo: groupsRepo,
      usersRepo: usersRepo,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}
