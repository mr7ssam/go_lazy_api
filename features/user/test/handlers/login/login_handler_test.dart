import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class _MockUsersRepo extends Mock implements IUsersRepo {}

class _MockTransactionManager extends Mock implements TransactionManager {}

class _MockJwtService extends Mock implements JwtService {}

void main() {
  late _MockUsersRepo usersRepo;
  late _MockTransactionManager transactionManager;
  late _MockJwtService jwtService;
  late LocalizationService localization;
  late LoginHandler handler;

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
    final claimsFallback = <String, dynamic>{};
    registerFallbackValue(claimsFallback);
  });

  setUp(() {
    usersRepo = _MockUsersRepo();
    transactionManager = _MockTransactionManager();
    jwtService = _MockJwtService();
    localization = LocalizationService();
    handler = LoginHandler(
      usersRepo: usersRepo,
      transactionManager: transactionManager,
      jwtService: jwtService,
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

  group('LoginHandler', () {
    test('returns NotFoundError when user not found', () async {
      when(() => usersRepo.getUserByEmail('missing@example.com')).thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const EmailLoginRequest(email: 'missing@example.com', otp: '123456'),
      );

      expect(result, isA<HandlerResult<LoginResponse>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.statusCode, equals(404));
          expect(error.message, equals(localization.translations.userNotFound));
        },
      );
    });

    test('returns 400 when OTP is invalid', () async {
      final user = User(
        id: 'user-1',
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@example.com',
        phoneNumber: '+19876543210',
        isEmailVerified: false,
        isPhoneVerified: false,
      );

      when(() => usersRepo.getUserByEmail(user.email)).thenAnswer(
        (_) async => user,
      );
      when(() => usersRepo.getUserOtp(user.id, UserOtpTypeEnum.email))
          .thenAnswer(
        (_) async => UserOtp(
          id: 'otp-1',
          userId: user.id,
          code: '654321',
          expiresAt: DateTime.utc(2025, 1, 1, 12),
          type: UserOtpTypeEnum.email,
        ),
      );

      final result = await handler.handle(
        EmailLoginRequest(email: user.email, otp: '123456'),
      );

      expect(result, isA<HandlerResult<LoginResponse>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<BadRequestError>());
          expect(error.statusCode, equals(400));
          expect(error.message, equals(localization.translations.invalidOtp));
        },
      );
      verifyNever(() => usersRepo.save(any()));
      verifyNever(() => usersRepo.invalidateUserOtp(any()));
      verifyNever(
        () => jwtService.generateTokens(
          userId: any(named: 'userId'),
          additionalClaims: any(named: 'additionalClaims'),
        ),
      );
    });

    test('returns tokens and marks email verified on success', () async {
      final user = User(
        id: 'user-2',
        firstName: 'Alex',
        lastName: 'Smith',
        email: 'alex@example.com',
        phoneNumber: '+1122334455',
        isEmailVerified: false,
        isPhoneVerified: false,
      );

      final otp = UserOtp(
        id: 'otp-2',
        userId: user.id,
        code: '123456',
        expiresAt: DateTime.utc(2025, 5, 1, 12),
        type: UserOtpTypeEnum.email,
      );

      when(() => usersRepo.getUserByEmail(user.email)).thenAnswer(
        (_) async => user,
      );
      when(() => usersRepo.getUserOtp(user.id, UserOtpTypeEnum.email))
          .thenAnswer(
        (_) async => otp,
      );
      when(() => usersRepo.save(any())).thenAnswer((_) async {});
      when(() => usersRepo.invalidateUserOtp(otp.id)).thenAnswer((_) async {});
      when(
        () => jwtService.generateTokens(
          userId: user.id,
          additionalClaims: any(named: 'additionalClaims'),
        ),
      ).thenReturn(
        const TokenPair(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
          expiresIn: 900,
        ),
      );

      final result = await handler.handle(
        EmailLoginRequest(email: user.email, otp: otp.code),
      );

      expect(result, isA<HandlerResult<LoginResponse>>());
      result.when(
        success: (response) {
          expect(response.accessToken, equals('access-token'));
          expect(response.refreshToken, equals('refresh-token'));
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );

      verify(() => transactionManager.runInTransaction(any())).called(2);
      verify(
        () => usersRepo.save(
          any(
            that: predicate<User>(
              (updated) => updated.id == user.id && updated.isEmailVerified,
            ),
          ),
        ),
      ).called(1);
      verify(() => usersRepo.invalidateUserOtp(otp.id)).called(1);
    });

    test('marks phone verified for phone login', () async {
      final user = User(
        id: 'user-3',
        firstName: 'Sam',
        lastName: 'Taylor',
        email: 'sam@example.com',
        phoneNumber: '+10987654321',
        isEmailVerified: true,
        isPhoneVerified: false,
      );

      final otp = UserOtp(
        id: 'otp-3',
        userId: user.id,
        code: '987654',
        expiresAt: DateTime.utc(2025, 7, 1, 9),
        type: UserOtpTypeEnum.phone,
      );

      when(() => usersRepo.getUserByPhoneNumber(user.phoneNumber)).thenAnswer(
        (_) async => user,
      );
      when(() => usersRepo.getUserOtp(user.id, UserOtpTypeEnum.phone))
          .thenAnswer(
        (_) async => otp,
      );
      when(() => usersRepo.save(any())).thenAnswer((_) async {});
      when(() => usersRepo.invalidateUserOtp(otp.id)).thenAnswer((_) async {});
      when(
        () => jwtService.generateTokens(
          userId: user.id,
          additionalClaims: any(named: 'additionalClaims'),
        ),
      ).thenReturn(
        const TokenPair(
          accessToken: 'access-token-phone',
          refreshToken: 'refresh-token-phone',
          expiresIn: 900,
        ),
      );

      final result = await handler.handle(
        PhoneLoginRequest(phoneNumber: user.phoneNumber, otp: otp.code),
      );

      expect(result, isA<HandlerResult<LoginResponse>>());
      result.when(
        success: (response) {
          expect(response.accessToken, equals('access-token-phone'));
          expect(response.refreshToken, equals('refresh-token-phone'));
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );

      verify(
        () => usersRepo.save(
          any(
            that: predicate<User>(
              (updated) => updated.id == user.id && updated.isPhoneVerified,
            ),
          ),
        ),
      ).called(1);
      verify(() => usersRepo.invalidateUserOtp(otp.id)).called(1);
    });
  });
}
