import 'dart:convert';
import 'dart:io';

import 'package:common/src/handler/handler_result.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:group/group_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';

import '../../../routes/groups/[id]/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockGetGroupHandler extends Mock implements GetGroupHandler {}

class _MockUpdateGroupHandler extends Mock implements UpdateGroupHandler {}

class _MockDeleteGroupHandler extends Mock implements DeleteGroupHandler {}

class _FakeGetGroupRequest extends Fake implements GetGroupRequest {}

class _FakeUpdateGroupRequest extends Fake implements UpdateGroupRequest {}

class _FakeDeleteGroupRequest extends Fake implements DeleteGroupRequest {}

void main() {
  late _MockRequestContext context;
  late User testUser;
  const groupId = 'group-123';

  setUpAll(() {
    registerFallbackValue(_FakeGetGroupRequest());
    registerFallbackValue(_FakeUpdateGroupRequest());
    registerFallbackValue(_FakeDeleteGroupRequest());
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

  group('GET /groups/[id]', () {
    test('returns 405 when method is not GET, PUT, or DELETE', () async {
      when(() => context.request).thenReturn(
        Request('POST', Uri.parse('https://example.com/groups/$groupId')),
      );

      final response = await route.onRequest(context, groupId);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to GetGroupHandler on GET', () async {
      final handler = _MockGetGroupHandler();
      final now = DateTime.now().toUtc();

      when(() => context.request).thenReturn(
        Request('GET', Uri.parse('https://example.com/groups/$groupId')),
      );
      when(() => context.read<GetGroupHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => HandlerResult<GetGroupResponse>.success(
          data: GetGroupResponse(
            id: groupId,
            name: 'Test Group',
            createdBy: testUser.id,
            createdAt: now,
            memberCount: 5,
          ),
        ),
      );

      final response = await route.onRequest(context, groupId);

      expect(response.statusCode, equals(HttpStatus.ok));
      verify(
        () => handler.handle(
          any(
            that: isA<GetGroupRequest>()
                .having((r) => r.groupId, 'groupId', groupId)
                .having((r) => r.userId, 'userId', testUser.id),
          ),
        ),
      ).called(1);
    });
  });

  group('PUT /groups/[id]', () {
    test('delegates to UpdateGroupHandler on PUT', () async {
      final handler = _MockUpdateGroupHandler();
      final now = DateTime.now().toUtc();

      when(() => context.request).thenReturn(
        Request(
          'PUT',
          Uri.parse('https://example.com/groups/$groupId'),
          body: json.encode({
            'name': 'Updated Group',
            'description': 'Updated description',
          }),
          headers: {'content-type': 'application/json'},
        ),
      );
      when(() => context.read<UpdateGroupHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => HandlerResult<UpdateGroupResponse>.success(
          data: UpdateGroupResponse(
            id: groupId,
            name: 'Updated Group',
            description: 'Updated description',
            createdBy: testUser.id,
            createdAt: now,
          ),
        ),
      );

      final response = await route.onRequest(context, groupId);

      expect(response.statusCode, equals(HttpStatus.ok));
      verify(
        () => handler.handle(
          any(
            that: isA<UpdateGroupRequest>()
                .having((r) => r.groupId, 'groupId', groupId)
                .having((r) => r.userId, 'userId', testUser.id)
                .having((r) => r.name, 'name', 'Updated Group'),
          ),
        ),
      ).called(1);
    });
  });

  group('DELETE /groups/[id]', () {
    test('delegates to DeleteGroupHandler on DELETE', () async {
      final handler = _MockDeleteGroupHandler();

      when(() => context.request).thenReturn(
        Request('DELETE', Uri.parse('https://example.com/groups/$groupId')),
      );
      when(() => context.read<DeleteGroupHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => const HandlerResult<void>.success(data: null),
      );

      final response = await route.onRequest(context, groupId);

      expect(response.statusCode, equals(HttpStatus.noContent));
      verify(
        () => handler.handle(
          any(
            that: isA<DeleteGroupRequest>()
                .having((r) => r.groupId, 'groupId', groupId)
                .having((r) => r.userId, 'userId', testUser.id),
          ),
        ),
      ).called(1);
    });
  });
}
