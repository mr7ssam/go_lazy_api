import 'dart:convert';
import 'dart:io';

import 'package:common/src/handler/handler_result.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:group/group_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';

import '../../../../routes/groups/[id]/members/[memberId].dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRemoveMemberHandler extends Mock implements RemoveMemberHandler {}

class _MockUpdateMemberRoleHandler extends Mock
    implements UpdateMemberRoleHandler {}

class _FakeRemoveMemberRequest extends Fake implements RemoveMemberRequest {}

class _FakeUpdateMemberRoleRequest extends Fake
    implements UpdateMemberRoleRequest {}

void main() {
  late _MockRequestContext context;
  late User testUser;
  const groupId = 'group-123';
  const memberId = 'member-456';

  setUpAll(() {
    registerFallbackValue(_FakeRemoveMemberRequest());
    registerFallbackValue(_FakeUpdateMemberRoleRequest());
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

  group('DELETE /groups/[id]/members/[memberId]', () {
    test('returns 405 when method is not DELETE or PUT', () async {
      when(() => context.request).thenReturn(
        Request(
          'GET',
          Uri.parse('https://example.com/groups/$groupId/members/$memberId'),
        ),
      );

      final response = await route.onRequest(context, groupId, memberId);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to RemoveMemberHandler on DELETE', () async {
      final handler = _MockRemoveMemberHandler();

      when(() => context.request).thenReturn(
        Request(
          'DELETE',
          Uri.parse('https://example.com/groups/$groupId/members/$memberId'),
        ),
      );
      when(() => context.read<RemoveMemberHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => const HandlerResult<void>.success(data: null),
      );

      final response = await route.onRequest(context, groupId, memberId);

      expect(response.statusCode, equals(HttpStatus.noContent));
      verify(
        () => handler.handle(
          any(
            that: isA<RemoveMemberRequest>()
                .having((r) => r.groupId, 'groupId', groupId)
                .having(
                  (r) => r.requestingUserId,
                  'requestingUserId',
                  testUser.id,
                )
                .having(
                  (r) => r.targetUserId,
                  'targetUserId',
                  memberId,
                ),
          ),
        ),
      ).called(1);
    });
  });

  group('PUT /groups/[id]/members/[memberId]', () {
    test('delegates to UpdateMemberRoleHandler on PUT', () async {
      final handler = _MockUpdateMemberRoleHandler();

      when(() => context.request).thenReturn(
        Request(
          'PUT',
          Uri.parse('https://example.com/groups/$groupId/members/$memberId'),
          body: json.encode({
            'role': 'admin',
          }),
          headers: {'content-type': 'application/json'},
        ),
      );
      when(() => context.read<UpdateMemberRoleHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => const HandlerResult<UpdateMemberRoleResponse>.success(
          data: UpdateMemberRoleResponse(
            id: 'membership-id',
            groupId: groupId,
            userId: memberId,
            role: GroupMemberRoleEnum.admin,
          ),
        ),
      );

      final response = await route.onRequest(context, groupId, memberId);

      expect(response.statusCode, equals(HttpStatus.ok));
      verify(
        () => handler.handle(
          any(
            that: isA<UpdateMemberRoleRequest>()
                .having((r) => r.groupId, 'groupId', groupId)
                .having(
                  (r) => r.requestingUserId,
                  'requestingUserId',
                  testUser.id,
                )
                .having((r) => r.targetUserId, 'targetUserId', memberId)
                .having(
                  (r) => r.newRole,
                  'newRole',
                  GroupMemberRoleEnum.admin,
                ),
          ),
        ),
      ).called(1);
    });
  });
}
