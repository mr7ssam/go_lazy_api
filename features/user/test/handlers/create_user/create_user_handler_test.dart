import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class _MockUsersRepo extends Mock implements IUsersRepo {}

class _MockTransactionManager extends Mock implements TransactionManager {}

class _FakeUniqueViolationException extends Fake
    implements UniqueViolationException {}

void main() {
  late _MockUsersRepo usersRepo;
  late _MockTransactionManager transactionManager;
  late LocalizationService localization;
  late CreateUserHandler handler;

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
    handler = CreateUserHandler(
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

  group('CreateUserHandler', () {
    test('returns success when user is created successfully', () async {
      final createdUser = User(
        id: 'created-user-id',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        isEmailVerified: false,
        isPhoneVerified: false,
      );

      final createdOtp = UserOtp(
        id: 'created-otp-id',
        userId: createdUser.id,
        code: '123456',
        expiresAt: DateTime.utc(2025, 1, 1, 12),
        type: UserOtpTypeEnum.email,
      );

      when(() => usersRepo.createUser(any())).thenAnswer(
        (_) async => createdUser,
      );
      when(() => usersRepo.createUserOtp(any())).thenAnswer(
        (_) async => createdOtp,
      );

      final result = await handler.handle(
        const CreateUserRequest(
          email: 'john@example.com',
          firstName: 'John',
          lastName: 'Doe',
          phoneNumber: '+1234567890',
        ),
      );

      expect(result, isA<HandlerResult<void>>());
      result.when(
        success: (_) {
          // Success case - user created
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );
      verify(() => transactionManager.runInTransaction(any())).called(1);
      verify(() => usersRepo.createUser(any(that: isA<User>()))).called(1);
      verify(() => usersRepo.createUserOtp(any(that: isA<UserOtp>())))
          .called(1);
    });

    test('returns ConflictError when user already exists', () async {
      final exception = _FakeUniqueViolationException();

      when(() => usersRepo.createUser(any())).thenThrow(exception);

      final result = await handler.handle(
        const CreateUserRequest(
          email: 'john@example.com',
          firstName: 'John',
          lastName: 'Doe',
          phoneNumber: '+1234567890',
        ),
      );

      expect(result, isA<HandlerResult<void>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<ConflictError>());
          expect(error.statusCode, equals(409));
          expect(error.message,
              equals(localization.translations.userAlreadyExists));
        },
      );
      verify(() => transactionManager.runInTransaction(any())).called(1);
      verifyNever(() => usersRepo.createUserOtp(any()));
    });
  });
}
