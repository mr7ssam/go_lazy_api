import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';
import 'package:user/user_data.dart';
import 'package:user/user_domain.dart' hide IUsersRepo;

void main() {
  late UsersRepoTestContext context;

  setUp(() async {
    context = await UsersRepoTestContext.create();
  });

  tearDown(() async {
    await context.dispose();
  });

  User buildUser({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
  }) {
    return User.create(
      firstName: firstName ?? 'John',
      lastName: lastName ?? 'Doe',
      email: email ?? 'john.doe@example.com',
      phoneNumber: phoneNumber ?? '+1234567890',
      photoUrl: photoUrl,
    );
  }

  group('UsersRepo', () {
    test('createUser inserts a user and returns domain model', () async {
      final user = buildUser();

      final created = await context.usersRepo.createUser(user);

      expect(created.id, user.id);
      expect(created.email, user.email);
      expect(created.firstName, user.firstName);

      final stored = await context.usersRepo.getUserById(created.id);

      expect(stored, isNotNull);
      expect(stored!.email, user.email);
      expect(stored.firstName, user.firstName);
      expect(stored.lastName, user.lastName);
    });

    test('getUserById returns the stored user when found', () async {
      final user = buildUser(email: 'user1@example.com');
      await context.usersRepo.createUser(user);

      final result = await context.usersRepo.getUserById(user.id);

      expect(result, isNotNull);
      expect(result!.id, user.id);
      expect(result.email, user.email);
    });

    test('getUserById returns null when user does not exist', () async {
      final result = await context.usersRepo.getUserById('missing-id');

      expect(result, isNull);
    });

    test('getUserByEmail looks up user by email address', () async {
      final user = buildUser(email: 'lookup@example.com');
      await context.usersRepo.createUser(user);

      final result =
          await context.usersRepo.getUserByEmail('lookup@example.com');

      expect(result, isNotNull);
      expect(result!.id, user.id);
    });

    test('getUserByEmail returns null when email not found', () async {
      final result =
          await context.usersRepo.getUserByEmail('missing@example.com');

      expect(result, isNull);
    });

    test('getUserByPhoneNumber looks up user by phone number', () async {
      final user = buildUser(
        email: 'phone@example.com',
        phoneNumber: '+19876543210',
      );
      await context.usersRepo.createUser(user);

      final result =
          await context.usersRepo.getUserByPhoneNumber('+19876543210');

      expect(result, isNotNull);
      expect(result!.id, user.id);
    });

    test('getUserByPhoneNumber returns null when not found', () async {
      final result =
          await context.usersRepo.getUserByPhoneNumber('+10000000000');

      expect(result, isNull);
    });

    test('save updates an existing user', () async {
      final user = buildUser(email: 'update@example.com');
      final created = await context.usersRepo.createUser(user);
      final updated = created.copyWith(
        firstName: 'Jane',
        isEmailVerified: true,
      );

      await context.usersRepo.save(updated);

      final stored = await context.usersRepo.getUserById(created.id);

      expect(stored, isNotNull);
      expect(stored!.firstName, 'Jane');
      expect(stored.isEmailVerified, isTrue);
    });

    test('createUserOtp inserts and returns a user otp', () async {
      final user = buildUser(email: 'otp@example.com');
      final createdUser = await context.usersRepo.createUser(user);
      final otp = UserOtp(
        id: 'otp-1',
        userId: createdUser.id,
        code: '123456',
        expiresAt: DateTime.utc(2025, 1, 1, 12),
        type: UserOtpTypeEnum.email,
      );

      final createdOtp = await context.usersRepo.createUserOtp(otp);

      expect(createdOtp.id, otp.id);
      expect(createdOtp.code, '123456');
      expect(createdOtp.userId, createdUser.id);
    });

    test('getUserOtp returns OTP by user and type', () async {
      final user = buildUser(email: 'otp-fetch@example.com');
      final createdUser = await context.usersRepo.createUser(user);
      final otp = UserOtp(
        id: 'otp-2',
        userId: createdUser.id,
        code: '654321',
        expiresAt: DateTime.utc(2025, 6, 1, 9),
        type: UserOtpTypeEnum.phone,
      );
      await context.usersRepo.createUserOtp(otp);

      final result = await context.usersRepo.getUserOtp(
        createdUser.id,
        UserOtpTypeEnum.phone,
      );

      expect(result, isNotNull);
      expect(result!.id, otp.id);
      expect(result.code, otp.code);
    });

    test('getUserOtp returns null when no OTP exists', () async {
      final result = await context.usersRepo.getUserOtp(
        'unknown-user',
        UserOtpTypeEnum.login,
      );

      expect(result, isNull);
    });

    test('invalidateUserOtp removes an existing OTP', () async {
      final user = buildUser(email: 'otp-remove@example.com');
      final createdUser = await context.usersRepo.createUser(user);
      final otp = UserOtp(
        id: 'otp-3',
        userId: createdUser.id,
        code: '222333',
        expiresAt: DateTime.utc(2025, 3, 1, 8),
        type: UserOtpTypeEnum.login,
      );
      await context.usersRepo.createUserOtp(otp);

      await context.usersRepo.invalidateUserOtp('otp-3');

      final result = await context.usersRepo.getUserOtp(
        createdUser.id,
        UserOtpTypeEnum.login,
      );

      expect(result, isNull);
    });

    test('fromToken returns user when token is valid', () async {
      final user = buildUser(email: 'token@example.com');
      final created = await context.usersRepo.createUser(user);
      final tokenPair = context.jwtService.generateTokens(userId: created.id);

      final result = await context.usersRepo.fromToken(tokenPair.accessToken);

      expect(result, isNotNull);
      expect(result!.id, created.id);
    });

    test('fromToken returns null when token is invalid', () async {
      final result = await context.usersRepo.fromToken('invalid-token');

      expect(result, isNull);
    });

    test('fromToken returns null when user is missing', () async {
      final tokenPair =
          context.jwtService.generateTokens(userId: 'missing-user');

      final result = await context.usersRepo.fromToken(tokenPair.accessToken);

      expect(result, isNull);
    });
  });
}

class UsersRepoTestContext {
  UsersRepoTestContext._({
    required this.database,
    required this.usersRepo,
    required this.jwtService,
  });

  final Database database;
  final UsersRepo usersRepo;
  final JwtService jwtService;

  static Future<UsersRepoTestContext> create() async {
    final database = Database(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = ON');
    final usersDao = UsersDao(database);
    final jwtService = JwtService(
      accessTokenSecret: 'access-secret',
      refreshTokenSecret: 'refresh-secret',
    );

    final usersRepo = UsersRepo(
      usersDao: usersDao,
      jwtService: jwtService,
      userOutputTransformer: UserOutputTransformer(),
      userInputTransformer: UserInputTransformer(),
      userOtpInputTransformer: UserOtpInputTransformer(),
      userOtpOutputTransformer: UserOtpOutputTransformer(),
    );

    return UsersRepoTestContext._(
      database: database,
      usersRepo: usersRepo,
      jwtService: jwtService,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}
