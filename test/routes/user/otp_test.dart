import 'dart:convert';
import 'dart:io';

import 'package:common/src/handler/handler_result.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

import '../../../routes/user/otp.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequestOtpHandler extends Mock implements RequestOtpHandler {}

class _FakeRequestOtpRequest extends Fake implements RequestOtpRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeRequestOtpRequest());
  });

  group('POST /user/otp', () {
    test('returns 405 when method is not POST', () async {
      final context = _MockRequestContext();

      when(() => context.request).thenReturn(
        Request('GET', Uri.parse('https://example.com/user/otp')),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to RequestOtpHandler on POST', () async {
      final context = _MockRequestContext();
      final handler = _MockRequestOtpHandler();

      when(() => context.request).thenReturn(
        Request(
          'POST',
          Uri.parse('https://example.com/user/otp'),
          body: json.encode({
            'email': 'john@example.com',
          }),
          headers: {'content-type': 'application/json'},
        ),
      );
      when(() => context.read<RequestOtpHandler>()).thenReturn(handler);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => HandlerResult<RequestOtpResponse>.success(
          data: RequestOtpResponse(
            message: 'sent',
            expiresAt: DateTime.now().add(const Duration(minutes: 5)),
          ),
        ),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      verify(
        () => handler.handle(
          any(
            that: isA<EmailOtpRequest>().having(
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
