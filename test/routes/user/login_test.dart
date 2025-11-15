import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

import '../../../routes/user/login.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockLoginHandler extends Mock implements LoginHandler {}

class _FakeLoginRequest extends Fake implements LoginRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeLoginRequest());
  });

  group('POST /user/login', () {
    test('returns 405 when method is not POST', () async {
      final context = _MockRequestContext();

      when(() => context.request).thenReturn(
        Request('GET', Uri.parse('https://example.com/user/login')),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to LoginHandler on POST', () async {
      final context = _MockRequestContext();
      final handler = _MockLoginHandler();

      when(() => context.request).thenReturn(
        Request(
          'POST',
          Uri.parse('https://example.com/user/login'),
          body: json.encode({
            'email': 'john@example.com',
            'otp': '123456',
          }),
          headers: {'content-type': 'application/json'},
        ),
      );
      when(() => context.read<LoginHandler>()).thenReturn(handler);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => Response.json(body: {'status': 'ok'}),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      verify(
        () => handler.handle(
          any(
            that: isA<LoginRequest>().having(
              (request) => request.otp,
              'otp',
              '123456',
            ),
          ),
        ),
      ).called(1);
    });
  });
}
