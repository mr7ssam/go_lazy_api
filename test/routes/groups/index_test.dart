import 'dart:convert';
import 'dart:io';

import 'package:common/src/handler/handler_result.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:group/group_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';

import '../../../routes/groups/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockCreateGroupHandler extends Mock implements CreateGroupHandler {}

class _MockGetUserGroupsHandler extends Mock implements GetUserGroupsHandler {}

class _FakeCreateGroupRequest extends Fake implements CreateGroupRequest {}

class _FakeGetUserGroupsRequest extends Fake implements GetUserGroupsRequest {}

void main() {
  late _MockRequestContext context;
  late User testUser;

  setUpAll(() {
    registerFallbackValue(_FakeCreateGroupRequest());
    registerFallbackValue(_FakeGetUserGroupsRequest());
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

  group('POST /groups (create group)', () {
    test('returns 405 when method is not POST or GET', () async {
      when(() => context.request).thenReturn(
        Request('DELETE', Uri.parse('https://example.com/groups')),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to CreateGroupHandler on POST', () async {
      final handler = _MockCreateGroupHandler();
      final now = DateTime.now().toUtc();

      when(() => context.request).thenReturn(
        Request(
          'POST',
          Uri.parse('https://example.com/groups'),
          body: json.encode({
            'name': 'Test Group',
            'description': 'A test group',
            'userId': 'ignored-will-be-overwritten',
          }),
          headers: {'content-type': 'application/json'},
        ),
      );
      when(() => context.read<CreateGroupHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => HandlerResult<CreateGroupResponse>.success(
          data: CreateGroupResponse(
            id: 'group-123',
            name: 'Test Group',
            description: 'A test group',
            createdBy: testUser.id,
            createdAt: now,
          ),
        ),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.created));
      verify(
        () => handler.handle(
          any(
            that: isA<CreateGroupRequest>()
                .having((r) => r.name, 'name', 'Test Group')
                .having((r) => r.userId, 'userId', testUser.id),
          ),
        ),
      ).called(1);
    });
  });

  group('GET /groups (get user groups)', () {
    test('delegates to GetUserGroupsHandler on GET', () async {
      final handler = _MockGetUserGroupsHandler();
      final now = DateTime.now().toUtc();

      when(() => context.request).thenReturn(
        Request('GET', Uri.parse('https://example.com/groups')),
      );
      when(() => context.read<GetUserGroupsHandler>()).thenReturn(handler);
      when(() => context.read<User>()).thenReturn(testUser);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => HandlerResult<GetUserGroupsResponse>.success(
          data: GetUserGroupsResponse(
            groups: [
              GroupSummary(
                id: 'group-123',
                name: 'Test Group',
                createdBy: testUser.id,
                createdAt: now,
              ),
            ],
          ),
        ),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      verify(
        () => handler.handle(
          any(
            that: isA<GetUserGroupsRequest>()
                .having((r) => r.userId, 'userId', testUser.id),
          ),
        ),
      ).called(1);
    });
  });
}
