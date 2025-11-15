import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

import '../../../routes/user/refresh_token.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRefreshTokenHandler extends Mock implements RefreshTokenHandler {}

class _FakeRefreshTokenRequest extends Fake implements RefreshTokenRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeRefreshTokenRequest());
  });

  group('POST /user/refresh_token', () {
    test('returns 405 when method is not POST', () async {
      final context = _MockRequestContext();

      when(() => context.request).thenReturn(
        Request('GET', Uri.parse('https://example.com/user/refresh_token')),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to RefreshTokenHandler on POST', () async {
      final context = _MockRequestContext();
      final handler = _MockRefreshTokenHandler();

      when(() => context.request).thenReturn(
        Request(
          'POST',
          Uri.parse('https://example.com/user/refresh_token'),
          body: json.encode({
            'refresh_token': 'refresh-token',
          }),
          headers: {'content-type': 'application/json'},
        ),
      );
      when(() => context.read<RefreshTokenHandler>()).thenReturn(handler);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => Response.json(body: {'accessToken': 'new-token'}),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      verify(
        () => handler.handle(
          any(
            that: isA<RefreshTokenRequest>().having(
              (request) => request.refreshToken,
              'refreshToken',
              'refresh-token',
            ),
          ),
        ),
      ).called(1);
    });
  });
}
