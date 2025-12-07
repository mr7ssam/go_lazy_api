import 'package:common/common.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGroupsRepo extends Mock implements IGroupsRepo {}

void main() {
  late _MockGroupsRepo groupsRepo;
  late LocalizationService localization;
  late GetUserGroupsHandler handler;

  setUp(() {
    groupsRepo = _MockGroupsRepo();
    localization = LocalizationService();
    handler = GetUserGroupsHandler(
      groupsRepo: groupsRepo,
      localization: localization,
    );
  });

  group('GetUserGroupsHandler', () {
    test('returns empty list when user has no groups', () async {
      when(() => groupsRepo.getUserGroups('user-123')).thenAnswer(
        (_) async => [],
      );

      final result = await handler.handle(
        const GetUserGroupsRequest(userId: 'user-123'),
      );

      expect(result, isA<HandlerResult<GetUserGroupsResponse>>());
      result.when(
        success: (response) {
          expect(response.groups, isEmpty);
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );
      verify(() => groupsRepo.getUserGroups('user-123')).called(1);
    });

    test('returns list of groups when user has groups', () async {
      final groups = [
        Group(
          id: 'group-1',
          name: 'Group One',
          description: 'First group',
          imageUrl: 'https://example.com/image1.png',
          createdBy: 'user-123',
          createdAt: DateTime.utc(2025),
          isActive: true,
          updatedAt: DateTime.utc(2025, 1, 2),
        ),
        Group(
          id: 'group-2',
          name: 'Group Two',
          createdBy: 'user-456',
          createdAt: DateTime.utc(2025, 1, 3),
          isActive: true,
        ),
      ];

      when(() => groupsRepo.getUserGroups('user-123')).thenAnswer(
        (_) async => groups,
      );

      final result = await handler.handle(
        const GetUserGroupsRequest(userId: 'user-123'),
      );

      expect(result, isA<HandlerResult<GetUserGroupsResponse>>());
      result.when(
        success: (response) {
          expect(response.groups, hasLength(2));

          final firstGroup = response.groups[0];
          expect(firstGroup.id, equals('group-1'));
          expect(firstGroup.name, equals('Group One'));
          expect(firstGroup.description, equals('First group'));
          expect(firstGroup.imageUrl, equals('https://example.com/image1.png'));
          expect(firstGroup.createdBy, equals('user-123'));
          expect(firstGroup.updatedAt, isNotNull);

          final secondGroup = response.groups[1];
          expect(secondGroup.id, equals('group-2'));
          expect(secondGroup.name, equals('Group Two'));
          expect(secondGroup.description, isNull);
          expect(secondGroup.imageUrl, isNull);
          expect(secondGroup.createdBy, equals('user-456'));
          expect(secondGroup.updatedAt, isNull);
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );
    });

    test('returns InternalServerError when repository throws', () async {
      when(() => groupsRepo.getUserGroups('user-123')).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const GetUserGroupsRequest(userId: 'user-123'),
      );

      expect(result, isA<HandlerResult<GetUserGroupsResponse>>());
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

    test('maps group entity fields to GroupSummary correctly', () async {
      final group = Group(
        id: 'group-id',
        name: 'Test Group',
        description: 'Test Description',
        imageUrl: 'https://example.com/test.png',
        createdBy: 'creator-id',
        createdAt: DateTime.utc(2025, 6, 15, 10, 30),
        isActive: true,
        updatedAt: DateTime.utc(2025, 6, 16, 14, 45),
      );

      when(() => groupsRepo.getUserGroups('user-123')).thenAnswer(
        (_) async => [group],
      );

      final result = await handler.handle(
        const GetUserGroupsRequest(userId: 'user-123'),
      );

      result.when(
        success: (response) {
          final summary = response.groups.first;
          expect(summary.id, equals(group.id));
          expect(summary.name, equals(group.name));
          expect(summary.description, equals(group.description));
          expect(summary.imageUrl, equals(group.imageUrl));
          expect(summary.createdBy, equals(group.createdBy));
          expect(summary.createdAt, equals(group.createdAt));
          expect(summary.updatedAt, equals(group.updatedAt));
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );
    });
  });
}
