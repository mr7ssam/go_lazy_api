import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

import '../../../routes/user/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockGetUserHandler extends Mock implements GetUserHandler {}

class _FakeUser extends Fake implements User {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeUser());
  });

  group('GET /user', () {
    test('returns 200 with user data when GET and user exists', () async {
      final context = _MockRequestContext();
      final handler = _MockGetUserHandler();
      final user = User(
        id: 'user-1',
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@example.com',
        phoneNumber: '+1234567890',
        isEmailVerified: true,
        isPhoneVerified: false,
      );
      when(() => context.request).thenReturn(
        Request('GET', Uri.parse('https://example.com/user')),
      );
      when(() => context.read<GetUserHandler>()).thenReturn(handler);
      when<User>(() => context.read<User>()).thenReturn(user);
      when(() => handler.handle(user)).thenAnswer(
        (_) async => Response.json(body: {'id': user.id}),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      final body = json.decode(await response.body()) as Map<String, dynamic>;
      expect(body, equals({'id': user.id}));
    });

    test('returns 405 for non-GET methods', () async {
      final context = _MockRequestContext();

      when(() => context.request).thenReturn(
        Request('POST', Uri.parse('https://example.com/user')),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });
}
