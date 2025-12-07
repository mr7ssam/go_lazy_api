import 'dart:convert';
import 'dart:io';

import 'package:common/src/handler/handler_result.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:group/group_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';

import '../../../../routes/groups/[id]/members/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockGetGroupMembersHandler extends Mock
    implements GetGroupMembersHandler {}

class _MockAddMemberHandler extends Mock implements AddMemberHandler {}

class _FakeGetGroupMembersRequest extends Fake
    implements GetGroupMembersRequest {}

class _FakeAddMemberRequest extends Fake implements AddMemberRequest {}

void main() {
  late _MockRequestContext context;
  late User testUser;
  const groupId = 'group-123';

  setUpAll(() {
    registerFallbackValue(_FakeGetGroupMembersRequest());
    registerFallbackValue(_FakeAddMemberRequest());
  });

  setUp(() {
    context = _MockRequestContext();
    testUser = User(
      id: 'user-123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      phoneNumber: '+1234567890',
      isEmailVerified: true,
      isPhoneVerified: true,
    );
  });

  group('GET /groups/[id]/members', () {
    test('returns 405 when method is not GET or POST', () async {
      when(() => context.request).thenReturn(
        Request(
          'DELETE',
          Uri.parse('https://example.com/groups/$groupId/members'),
        ),
      );

      final response = await route.onRequest(context, groupId);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to GetGroupMembersHandler on GET', () async {
      final handler = _MockGetGroupMembersHandler();
      final now = DateTime.now().toUtc();

      when(() => context.request).thenReturn(
        Request(
          'GET',
          Uri.parse('https://example.com/groups/$groupId/members'),
        ),
      );
      when(() => context.read<GetGroupMembersHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => HandlerResult<GetGroupMembersResponse>.success(
          data: GetGroupMembersResponse(
            members: [
              MemberInfo(
                id: 'member-1',
                userId: testUser.id,
                firstName: testUser.firstName,
                lastName: testUser.lastName,
                email: testUser.email,
                phoneNumber: testUser.phoneNumber,
                role: GroupMemberRoleEnum.owner,
                joinedAt: now,
              ),
            ],
          ),
        ),
      );

      final response = await route.onRequest(context, groupId);

      expect(response.statusCode, equals(HttpStatus.ok));
      verify(
        () => handler.handle(
          any(
            that: isA<GetGroupMembersRequest>()
                .having((r) => r.groupId, 'groupId', groupId)
                .having((r) => r.userId, 'userId', testUser.id),
          ),
        ),
      ).called(1);
    });
  });

  group('POST /groups/[id]/members', () {
    test('delegates to AddMemberHandler on POST', () async {
      final handler = _MockAddMemberHandler();
      final now = DateTime.now().toUtc();
      const targetUserId = 'target-user-456';

      when(() => context.request).thenReturn(
        Request(
          'POST',
          Uri.parse('https://example.com/groups/$groupId/members'),
          body: json.encode({
            'targetUserId': targetUserId,
            'role': 'member',
          }),
          headers: {'content-type': 'application/json'},
        ),
      );
      when(() => context.read<AddMemberHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => HandlerResult<AddMemberResponse>.success(
          data: AddMemberResponse(
            id: 'member-2',
            groupId: groupId,
            userId: targetUserId,
            role: GroupMemberRoleEnum.member,
            joinedAt: now,
          ),
        ),
      );

      final response = await route.onRequest(context, groupId);

      expect(response.statusCode, equals(HttpStatus.created));
      verify(
        () => handler.handle(
          any(
            that: isA<AddMemberRequest>()
                .having((r) => r.groupId, 'groupId', groupId)
                .having(
                  (r) => r.requestingUserId,
                  'requestingUserId',
                  testUser.id,
                )
                .having(
                  (r) => r.targetUserId,
                  'targetUserId',
                  targetUserId,
                ),
          ),
        ),
      ).called(1);
    });
  });
}
