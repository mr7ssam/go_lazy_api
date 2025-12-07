import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGroupsRepo extends Mock implements IGroupsRepo {}

class _MockTransactionManager extends Mock implements TransactionManager {}

void main() {
  late _MockGroupsRepo groupsRepo;
  late _MockTransactionManager transactionManager;
  late LocalizationService localization;
  late CreateGroupHandler handler;

  setUpAll(() {
    registerFallbackValue(
      Group(
        id: 'group-id',
        name: 'Test Group',
        createdBy: 'user-id',
        createdAt: DateTime.utc(2025),
        isActive: true,
      ),
    );
    registerFallbackValue(
      GroupMember(
        id: 'member-id',
        groupId: 'group-id',
        userId: 'user-id',
        role: GroupMemberRoleEnum.owner,
        joinedAt: DateTime.utc(2025),
        isActive: true,
      ),
    );
    Future<void> transactionCallback() async {}
    registerFallbackValue(transactionCallback);
  });

  setUp(() {
    groupsRepo = _MockGroupsRepo();
    transactionManager = _MockTransactionManager();
    localization = LocalizationService();
    handler = CreateGroupHandler(
      groupsRepo: groupsRepo,
      transactionManager: transactionManager,
      localization: localization,
    );

    when(() => transactionManager.runInTransaction(any())).thenAnswer(
      (invocation) async {
        final callback =
            invocation.positionalArguments.first as Future<void> Function();
        await callback();
      },
    );
  });

  group('CreateGroupHandler', () {
    test('returns success when group is created successfully', () async {
      final createdGroup = Group(
        id: 'created-group-id',
        name: 'My Group',
        description: 'A test group',
        imageUrl: 'https://example.com/image.png',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        isActive: true,
      );

      final createdMember = GroupMember(
        id: 'member-id',
        groupId: createdGroup.id,
        userId: 'user-123',
        role: GroupMemberRoleEnum.owner,
        joinedAt: DateTime.utc(2025, 1, 1, 12),
        isActive: true,
      );

      when(() => groupsRepo.createGroup(any())).thenAnswer(
        (_) async => createdGroup,
      );
      when(() => groupsRepo.addMember(any())).thenAnswer(
        (_) async => createdMember,
      );

      final result = await handler.handle(
        const CreateGroupRequest(
          name: 'My Group',
          userId: 'user-123',
          description: 'A test group',
          imageUrl: 'https://example.com/image.png',
        ),
      );

      expect(result, isA<HandlerResult<CreateGroupResponse>>());
      result.when(
        success: (response) {
          expect(response.id, equals(createdGroup.id));
          expect(response.name, equals(createdGroup.name));
          expect(response.description, equals(createdGroup.description));
          expect(response.imageUrl, equals(createdGroup.imageUrl));
          expect(response.createdBy, equals(createdGroup.createdBy));
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );
      verify(() => transactionManager.runInTransaction(any())).called(1);
      verify(() => groupsRepo.createGroup(any(that: isA<Group>()))).called(1);
      verify(() => groupsRepo.addMember(any(that: isA<GroupMember>())))
          .called(1);
    });

    test('returns success when group is created without optional fields',
        () async {
      final createdGroup = Group(
        id: 'created-group-id',
        name: 'My Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        isActive: true,
      );

      final createdMember = GroupMember(
        id: 'member-id',
        groupId: createdGroup.id,
        userId: 'user-123',
        role: GroupMemberRoleEnum.owner,
        joinedAt: DateTime.utc(2025, 1, 1, 12),
        isActive: true,
      );

      when(() => groupsRepo.createGroup(any())).thenAnswer(
        (_) async => createdGroup,
      );
      when(() => groupsRepo.addMember(any())).thenAnswer(
        (_) async => createdMember,
      );

      final result = await handler.handle(
        const CreateGroupRequest(
          name: 'My Group',
          userId: 'user-123',
        ),
      );

      expect(result, isA<HandlerResult<CreateGroupResponse>>());
      result.when(
        success: (response) {
          expect(response.id, equals(createdGroup.id));
          expect(response.name, equals(createdGroup.name));
          expect(response.description, isNull);
          expect(response.imageUrl, isNull);
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );
    });

    test('returns InternalServerError when repository throws', () async {
      when(() => groupsRepo.createGroup(any())).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const CreateGroupRequest(
          name: 'My Group',
          userId: 'user-123',
        ),
      );

      expect(result, isA<HandlerResult<CreateGroupResponse>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<InternalServerError>());
          expect(error.statusCode, equals(500));
          expect(
            error.message,
            equals(localization.translations.internalServerError),
          );
        },
      );
    });

    test('adds creator as owner member', () async {
      final createdGroup = Group(
        id: 'created-group-id',
        name: 'My Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        isActive: true,
      );

      final createdMember = GroupMember(
        id: 'member-id',
        groupId: createdGroup.id,
        userId: 'user-123',
        role: GroupMemberRoleEnum.owner,
        joinedAt: DateTime.utc(2025, 1, 1, 12),
        isActive: true,
      );

      when(() => groupsRepo.createGroup(any())).thenAnswer(
        (_) async => createdGroup,
      );
      when(() => groupsRepo.addMember(any())).thenAnswer(
        (_) async => createdMember,
      );

      await handler.handle(
        const CreateGroupRequest(
          name: 'My Group',
          userId: 'user-123',
        ),
      );

      verify(
        () => groupsRepo.addMember(
          any(
            that: isA<GroupMember>()
                .having((m) => m.userId, 'userId', 'user-123')
                .having((m) => m.role, 'role', GroupMemberRoleEnum.owner),
          ),
        ),
      ).called(1);
    });
  });
}
