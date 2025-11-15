import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

void main() {
  group('RequestOtpRequest', () {
    group('fromJson', () {
      test('creates EmailOtpRequest when email is provided', () {
        final json = {
          'email': 'test@example.com',
        };

        final request = RequestOtpRequest.fromJson(json);

        expect(request, isA<EmailOtpRequest>());
        expect((request as EmailOtpRequest).email, 'test@example.com');
      });

      test('creates PhoneOtpRequest when phoneNumber is provided', () {
        final json = {
          'phoneNumber': '+1234567890',
        };

        final request = RequestOtpRequest.fromJson(json);

        expect(request, isA<PhoneOtpRequest>());
        expect((request as PhoneOtpRequest).phoneNumber, '+1234567890');
      });

      test('throws exception when neither email nor phoneNumber provided', () {
        final json = <String, dynamic>{};

        expect(
          () => RequestOtpRequest.fromJson(json),
          throwsException,
        );
      });

      test('exception message is descriptive', () {
        final json = <String, dynamic>{};

        expect(
          () => RequestOtpRequest.fromJson(json),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Invalid request: email or phoneNumber is required'),
            ),
          ),
        );
      });

      test('prefers email when both email and phoneNumber provided', () {
        final json = {
          'email': 'test@example.com',
          'phoneNumber': '+1234567890',
        };

        final request = RequestOtpRequest.fromJson(json);

        expect(request, isA<EmailOtpRequest>());
        expect((request as EmailOtpRequest).email, 'test@example.com');
      });
    });

    group('type checking', () {
      test('isEmailRequest returns true for EmailOtpRequest', () {
        const request = EmailOtpRequest(email: 'test@example.com');

        expect(request.isEmailRequest, isTrue);
        expect(request.isPhoneRequest, isFalse);
      });

      test('isPhoneRequest returns true for PhoneOtpRequest', () {
        const request = PhoneOtpRequest(phoneNumber: '+1234567890');

        expect(request.isPhoneRequest, isTrue);
        expect(request.isEmailRequest, isFalse);
      });
    });
  });

  group('EmailOtpRequest', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        const request = EmailOtpRequest(email: 'john@example.com');

        expect(request.email, 'john@example.com');
      });
    });

    group('fromJson', () {
      test('creates instance from valid JSON', () {
        final json = {
          'email': 'jane@example.com',
        };

        final request = EmailOtpRequest.fromJson(json);

        expect(request.email, 'jane@example.com');
      });
    });
  });

  group('PhoneOtpRequest', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        const request = PhoneOtpRequest(phoneNumber: '+9876543210');

        expect(request.phoneNumber, '+9876543210');
      });
    });

    group('fromJson', () {
      test('creates instance from valid JSON', () {
        final json = {
          'phoneNumber': '+1112223333',
        };

        final request = PhoneOtpRequest.fromJson(json);

        expect(request.phoneNumber, '+1112223333');
      });
    });
  });

  group('RequestOtpResponse', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        final expiresAt =
            DateTime.now().toUtc().add(const Duration(minutes: 10));
        final response = RequestOtpResponse(
          message: 'OTP sent successfully',
          expiresAt: expiresAt,
        );

        expect(response.message, 'OTP sent successfully');
        expect(response.expiresAt, expiresAt);
      });

      test('supports different messages', () {
        final response = RequestOtpResponse(
          message: 'Verification code sent to your email',
          expiresAt: DateTime.now().toUtc(),
        );

        expect(response.message, 'Verification code sent to your email');
      });
    });

    group('toJson', () {
      test('converts instance to JSON', () {
        final expiresAt = DateTime.utc(2024, 1, 15, 10, 30);
        final response = RequestOtpResponse(
          message: 'OTP sent',
          expiresAt: expiresAt,
        );

        final json = response.toJson();

        expect(json, {
          'message': 'OTP sent',
          'expiresAt': '2024-01-15T10:30:00.000Z',
        });
      });

      test('formats expiresAt as ISO8601 string', () {
        final expiresAt = DateTime.utc(2024, 12, 25, 15, 45, 30);
        final response = RequestOtpResponse(
          message: 'Test message',
          expiresAt: expiresAt,
        );

        final json = response.toJson();

        expect(json['expiresAt'], '2024-12-25T15:45:30.000Z');
        expect(json['expiresAt'], isA<String>());
      });

      test('JSON contains all expected keys', () {
        final response = RequestOtpResponse(
          message: 'Test',
          expiresAt: DateTime.now().toUtc(),
        );

        final json = response.toJson();

        expect(json.keys, containsAll(['message', 'expiresAt']));
        expect(json.keys.length, 2);
      });
    });
  });
}
