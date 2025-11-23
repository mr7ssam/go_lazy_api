import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class _MockUsersRepo extends Mock implements IUsersRepo {}

class _MockTransactionManager extends Mock implements TransactionManager {}

void main() {
  late _MockUsersRepo usersRepo;
  late _MockTransactionManager transactionManager;
  late LocalizationService localization;
  late RequestOtpHandler handler;

  setUpAll(() {
    registerFallbackValue(
      User(
        id: 'user-id',
        firstName: 'first',
        lastName: 'last',
        email: 'user@example.com',
        phoneNumber: '+10000000000',
        isEmailVerified: false,
        isPhoneVerified: false,
      ),
    );
    registerFallbackValue(
      UserOtp(
        id: 'otp-id',
        userId: 'user-id',
        code: '000000',
        expiresAt: DateTime.utc(2025),
        type: UserOtpTypeEnum.email,
      ),
    );
    Future<void> transactionCallback() async {}
    registerFallbackValue(transactionCallback);
  });

  setUp(() {
    usersRepo = _MockUsersRepo();
    transactionManager = _MockTransactionManager();
    localization = LocalizationService();
    handler = RequestOtpHandler(
      usersRepo: usersRepo,
      transactionManager: transactionManager,
      localization: localization,
    );

    when(() => transactionManager.runInTransaction(any())).thenAnswer(
      (invocation) async {
        final callback =
            invocation.positionalArguments.first as Future<void> Function();
        await callback();
      },
    );
  });

  group('RequestOtpHandler', () {
    test('returns NotFoundError when user not found for email request',
        () async {
      when(() => usersRepo.getUserByEmail('missing@example.com')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const EmailOtpRequest(email: 'missing@example.com'),
      );

      expect(result, isA<HandlerResult<RequestOtpResponse>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.statusCode, equals(404));
          expect(error.message, equals(localization.translations.userNotFound));
        },
      );
    });

    test('creates OTP and marks email verified when needed', () async {
      final user = User(
        id: 'user-1',
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@example.com',
        phoneNumber: '+1234567890',
        isEmailVerified: false,
        isPhoneVerified: true,
      );

      final createdOtp = UserOtp(
        id: 'otp-1',
        userId: user.id,
        code: '123456',
        expiresAt: DateTime.utc(2025, 2, 1, 12),
        type: UserOtpTypeEnum.email,
      );

      when(() => usersRepo.getUserByEmail(user.email)).thenAnswer(
        (_) async => user,
      );
      when(() => usersRepo.save(any())).thenAnswer((_) async {});
      when(() => usersRepo.createUserOtp(any())).thenAnswer(
        (_) async => createdOtp,
      );

      final result = await handler.handle(
        EmailOtpRequest(email: user.email),
      );

      expect(result, isA<HandlerResult<RequestOtpResponse>>());
      result.when(
        success: (response) {
          expect(
            response.message,
            equals(localization.translations.otpSentEmail),
          );
          expect(response.expiresAt, equals(createdOtp.expiresAt));
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );

      verify(() => usersRepo.save(any())).called(1);
      verify(() => usersRepo.createUserOtp(any())).called(1);
    });

    test('creates OTP without saving when phone already verified', () async {
      final user = User(
        id: 'user-2',
        firstName: 'Sam',
        lastName: 'Taylor',
        email: 'sam@example.com',
        phoneNumber: '+19876543210',
        isEmailVerified: true,
        isPhoneVerified: true,
      );

      final createdOtp = UserOtp(
        id: 'otp-2',
        userId: user.id,
        code: '987654',
        expiresAt: DateTime.utc(2025, 3, 1, 9),
        type: UserOtpTypeEnum.phone,
      );

      when(() => usersRepo.getUserByPhoneNumber(user.phoneNumber)).thenAnswer(
        (_) async => user,
      );
      when(() => usersRepo.createUserOtp(any())).thenAnswer(
        (_) async => createdOtp,
      );

      final result = await handler.handle(
        PhoneOtpRequest(phoneNumber: user.phoneNumber),
      );

      expect(result, isA<HandlerResult<RequestOtpResponse>>());
      result.when(
        success: (response) {
          expect(
            response.message,
            equals(localization.translations.otpSentPhone),
          );
          expect(response.expiresAt, equals(createdOtp.expiresAt));
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );

      verifyNever(() => usersRepo.save(any()));
      verify(() => usersRepo.createUserOtp(any())).called(1);
    });
  });
}
