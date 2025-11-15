import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

void main() {
  group('LoginRequest', () {
    group('fromJson', () {
      test('creates EmailLoginRequest when email is provided', () {
        final json = {
          'email': 'test@example.com',
          'otp': '123456',
        };

        final request = LoginRequest.fromJson(json);

        expect(request, isA<EmailLoginRequest>());
        expect(request.otp, '123456');
        expect((request as EmailLoginRequest).email, 'test@example.com');
      });

      test('creates PhoneLoginRequest when phoneNumber is provided', () {
        final json = {
          'phoneNumber': '+1234567890',
          'otp': '654321',
        };

        final request = LoginRequest.fromJson(json);

        expect(request, isA<PhoneLoginRequest>());
        expect(request.otp, '654321');
        expect((request as PhoneLoginRequest).phoneNumber, '+1234567890');
      });

      test('throws exception when neither email nor phoneNumber provided', () {
        final json = {
          'otp': '123456',
        };

        expect(
          () => LoginRequest.fromJson(json),
          throwsException,
        );
      });

      test('prefers email when both email and phoneNumber provided', () {
        final json = {
          'email': 'test@example.com',
          'phoneNumber': '+1234567890',
          'otp': '123456',
        };

        final request = LoginRequest.fromJson(json);

        expect(request, isA<EmailLoginRequest>());
        expect((request as EmailLoginRequest).email, 'test@example.com');
      });
    });

    group('type checking', () {
      test('isEmailLogin returns true for EmailLoginRequest', () {
        const request = EmailLoginRequest(
          email: 'test@example.com',
          otp: '123456',
        );

        expect(request.isEmailLogin, isTrue);
        expect(request.isPhoneLogin, isFalse);
      });

      test('isPhoneLogin returns true for PhoneLoginRequest', () {
        const request = PhoneLoginRequest(
          phoneNumber: '+1234567890',
          otp: '123456',
        );

        expect(request.isPhoneLogin, isTrue);
        expect(request.isEmailLogin, isFalse);
      });
    });
  });

  group('EmailLoginRequest', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        const request = EmailLoginRequest(
          email: 'test@example.com',
          otp: '123456',
        );

        expect(request.email, 'test@example.com');
        expect(request.otp, '123456');
      });
    });

    group('fromJson', () {
      test('creates instance from valid JSON', () {
        final json = {
          'email': 'john@example.com',
          'otp': '999888',
        };

        final request = EmailLoginRequest.fromJson(json);

        expect(request.email, 'john@example.com');
        expect(request.otp, '999888');
      });
    });
  });

  group('PhoneLoginRequest', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        const request = PhoneLoginRequest(
          phoneNumber: '+9876543210',
          otp: '654321',
        );

        expect(request.phoneNumber, '+9876543210');
        expect(request.otp, '654321');
      });
    });

    group('fromJson', () {
      test('creates instance from valid JSON', () {
        final json = {
          'phoneNumber': '+1112223333',
          'otp': '777666',
        };

        final request = PhoneLoginRequest.fromJson(json);

        expect(request.phoneNumber, '+1112223333');
        expect(request.otp, '777666');
      });
    });
  });

  group('LoginResponse', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        final response = LoginResponse(
          accessToken: 'access-token-123',
          refreshToken: 'refresh-token-456',
        );

        expect(response.accessToken, 'access-token-123');
        expect(response.refreshToken, 'refresh-token-456');
      });
    });

    group('fromJson', () {
      test('creates instance from valid JSON', () {
        final json = {
          'accessToken': 'test-access-token',
          'refreshToken': 'test-refresh-token',
        };

        final response = LoginResponse.fromJson(json);

        expect(response.accessToken, 'test-access-token');
        expect(response.refreshToken, 'test-refresh-token');
      });
    });

    group('toJson', () {
      test('converts instance to JSON', () {
        final response = LoginResponse(
          accessToken: 'my-access-token',
          refreshToken: 'my-refresh-token',
        );

        final json = response.toJson();

        expect(json, {
          'accessToken': 'my-access-token',
          'refreshToken': 'my-refresh-token',
        });
      });
    });
  });
}
