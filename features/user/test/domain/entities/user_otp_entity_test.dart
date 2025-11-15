import 'package:test/test.dart';
import 'package:user/user_domain.dart';

void main() {
  group('UserOtp', () {
    group('constructor', () {
      test('creates instance with all required fields', () {
        final expiresAt =
            DateTime.now().toUtc().add(const Duration(minutes: 10));
        final userOtp = UserOtp(
          id: 'otp-123',
          userId: 'user-456',
          code: '123456',
          expiresAt: expiresAt,
          type: UserOtpTypeEnum.email,
        );

        expect(userOtp.id, 'otp-123');
        expect(userOtp.userId, 'user-456');
        expect(userOtp.code, '123456');
        expect(userOtp.expiresAt, expiresAt);
        expect(userOtp.type, UserOtpTypeEnum.email);
      });

      test('supports phone type', () {
        final userOtp = UserOtp(
          id: 'otp-789',
          userId: 'user-123',
          code: '654321',
          expiresAt: DateTime.now().toUtc(),
          type: UserOtpTypeEnum.phone,
        );

        expect(userOtp.type, UserOtpTypeEnum.phone);
      });

      test('supports login type', () {
        final userOtp = UserOtp(
          id: 'otp-abc',
          userId: 'user-def',
          code: '999888',
          expiresAt: DateTime.now().toUtc(),
          type: UserOtpTypeEnum.login,
        );

        expect(userOtp.type, UserOtpTypeEnum.login);
      });
    });

    group('create constructor', () {
      test('generates OTP with default values', () {
        final beforeCreation = DateTime.now().toUtc();

        final userOtp = UserOtp.create(
          userId: 'user-123',
          type: UserOtpTypeEnum.email,
        );

        final afterCreation = DateTime.now().toUtc();

        expect(userOtp.id, isNotEmpty);
        expect(userOtp.userId, 'user-123');
        expect(userOtp.type, UserOtpTypeEnum.email);

        // Verify code is 6 digits
        expect(userOtp.code.length, 6);
        expect(int.tryParse(userOtp.code), isNotNull);
        expect(int.parse(userOtp.code), greaterThanOrEqualTo(0));
        expect(int.parse(userOtp.code), lessThan(1000000));

        // Verify expiration is approximately 10 minutes from now
        expect(
          userOtp.expiresAt
              .isAfter(beforeCreation.add(const Duration(minutes: 9))),
          isTrue,
          reason: 'expiresAt should be after current time + 9 minutes',
        );
        expect(
          userOtp.expiresAt
              .isBefore(afterCreation.add(const Duration(minutes: 11))),
          isTrue,
          reason: 'expiresAt should be before current time + 11 minutes',
        );
      });

      test('generates unique codes for multiple OTPs', () {
        final codes = <String>{};

        // Generate 100 OTPs to check uniqueness
        for (var i = 0; i < 100; i++) {
          final userOtp = UserOtp.create(
            userId: 'user-$i',
            type: UserOtpTypeEnum.email,
          );
          codes.add(userOtp.code);
        }

        // While it's theoretically possible for duplicates, with 1 million
        // possible codes, 100 generations should typically be unique
        expect(
          codes.length,
          greaterThan(95),
          reason: 'Should generate mostly unique codes',
        );
      });

      test('creates OTP for phone type', () {
        final userOtp = UserOtp.create(
          userId: 'user-456',
          type: UserOtpTypeEnum.phone,
        );

        expect(userOtp.type, UserOtpTypeEnum.phone);
        expect(userOtp.userId, 'user-456');
        expect(userOtp.code.length, 6);
      });

      test('creates OTP for login type', () {
        final userOtp = UserOtp.create(
          userId: 'user-789',
          type: UserOtpTypeEnum.login,
        );

        expect(userOtp.type, UserOtpTypeEnum.login);
        expect(userOtp.userId, 'user-789');
        expect(userOtp.code.length, 6);
      });

      test('creates OTP with UTC timestamp', () {
        final userOtp = UserOtp.create(
          userId: 'user-123',
          type: UserOtpTypeEnum.email,
        );

        // Verify the timestamp is in UTC
        expect(userOtp.expiresAt.isUtc, isTrue);
      });
    });

    group('UserOtpTypeEnum', () {
      test('has email type', () {
        expect(UserOtpTypeEnum.email, isNotNull);
        expect(UserOtpTypeEnum.values, contains(UserOtpTypeEnum.email));
      });

      test('has phone type', () {
        expect(UserOtpTypeEnum.phone, isNotNull);
        expect(UserOtpTypeEnum.values, contains(UserOtpTypeEnum.phone));
      });

      test('has login type', () {
        expect(UserOtpTypeEnum.login, isNotNull);
        expect(UserOtpTypeEnum.values, contains(UserOtpTypeEnum.login));
      });

      test('has exactly 3 types', () {
        expect(UserOtpTypeEnum.values.length, 3);
      });
    });
  });
}
