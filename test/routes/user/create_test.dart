import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

import '../../../routes/user/create.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockCreateUserHandler extends Mock implements CreateUserHandler {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const CreateUserRequest(
        email: 'john@example.com',
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '+1234567890',
      ),
    );
  });

  group('POST /user/create', () {
    test('returns 405 when method is not POST', () async {
      final context = _MockRequestContext();

      when(() => context.request).thenReturn(
        Request('GET', Uri.parse('https://example.com/user/create')),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to CreateUserHandler on POST', () async {
      final context = _MockRequestContext();
      final handler = _MockCreateUserHandler();

      when(() => context.request).thenReturn(
        Request(
          'POST',
          Uri.parse('https://example.com/user/create'),
          body: json.encode({
            'email': 'john@example.com',
            'firstName': 'John',
            'lastName': 'Doe',
            'phoneNumber': '+1234567890',
          }),
          headers: {'content-type': 'application/json'},
        ),
      );
      when(() => context.read<CreateUserHandler>()).thenReturn(handler);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => Response(statusCode: HttpStatus.created),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.created));
      verify(
        () => handler.handle(
          any(
            that: isA<CreateUserRequest>().having(
              (request) => request.email,
              'email',
              'john@example.com',
            ),
          ),
        ),
      ).called(1);
    });
  });
}
