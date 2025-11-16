import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:common/src/handler/handler_result.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

import '../../../routes/user/image.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockUploadUserPhotoHandler extends Mock
    implements UploadUserPhotoHandler {}

class _MockRequest extends Mock implements Request {}

class _FakeUploadUserPhotoRequest extends Fake
    implements UploadUserPhotoRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      UploadUserPhotoResponse(photoUrl: 'https://example.com/avatar.png'),
    );
    registerFallbackValue(
      _FakeUploadUserPhotoRequest(),
    );
  });

  group('POST /user/image', () {
    test('returns 405 when method is not POST', () async {
      final context = _MockRequestContext();

      when(() => context.request).thenReturn(
        Request('GET', Uri.parse('https://example.com/user/image')),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('delegates to UploadUserPhotoHandler on POST', () async {
      final context = _MockRequestContext();
      final handler = _MockUploadUserPhotoHandler();
      final request = _MockRequest();
      final user = User(
        id: 'user-1',
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@example.com',
        phoneNumber: '+1234567890',
        isEmailVerified: true,
        isPhoneVerified: true,
      );
      final formData = FormData(
        fields: const {},
        files: {
          'avatar': UploadedFile(
            'avatar.png',
            ContentType('image', 'png'),
            Stream.fromIterable(<List<int>>[
              List<int>.from([1, 2, 3, 4]),
            ]),
          ),
        },
      );

      when(() => context.request).thenReturn(request);
      when(() => request.method).thenReturn(HttpMethod.post);
      when(request.formData).thenAnswer((_) async => formData);
      when(() => context.read<User>()).thenReturn(user);
      when(() => context.read<UploadUserPhotoHandler>()).thenReturn(handler);
      when(() => handler.handle(any())).thenAnswer(
        (_) async => HandlerResult<UploadUserPhotoResponse>.success(
          data: UploadUserPhotoResponse(
            photoUrl: 'https://example.com/avatar.png',
          ),
        ),
      );

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      final body = json.decode(await response.body()) as Map<String, dynamic>;
      expect(body['photoUrl'], equals('https://example.com/avatar.png'));
      verify(() => handler.handle(any())).called(1);
    });
  });
}
