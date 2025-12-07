import 'package:common/common.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:user/user_data.dart';
import 'package:user/user_domain.dart';

class UsersRepo implements IUsersRepo {
  const UsersRepo({
    required UsersDao usersDao,
    required JwtService jwtService,
    required UserOutputTransformer userOutputTransformer,
    required UserInputTransformer userInputTransformer,
    required UserOtpInputTransformer userOtpInputTransformer,
    required UserOtpOutputTransformer userOtpOutputTransformer,
  })  : _usersDao = usersDao,
        _jwtService = jwtService,
        _userOutputTransformer = userOutputTransformer,
        _userInputTransformer = userInputTransformer,
        _userOtpInputTransformer = userOtpInputTransformer,
        _userOtpOutputTransformer = userOtpOutputTransformer;

  final UsersDao _usersDao;
  final JwtService _jwtService;
  final UserOutputTransformer _userOutputTransformer;
  final UserInputTransformer _userInputTransformer;
  final UserOtpInputTransformer _userOtpInputTransformer;
  final UserOtpOutputTransformer _userOtpOutputTransformer;

  @override
  Future<User> createUser(User user) async {
    final createdUser =
        await _usersDao.into(_usersDao.userTable).insertReturning(
              _userInputTransformer.transform(user),
            );

    return _userOutputTransformer.transform(createdUser);
  }

  @override
  Future<User?> getUserById(String id) async {
    final userData = await (_usersDao.select(_usersDao.userTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (userData == null) {
      return null;
    }

    return _userOutputTransformer.transform(userData);
  }

  @override
  Future<UserOtp> createUserOtp(UserOtp userOtp) async {
    final createdOtp =
        await _usersDao.into(_usersDao.userOtpTable).insertReturning(
              _userOtpInputTransformer.transform(userOtp),
            );

    return _userOtpOutputTransformer.transform(createdOtp);
  }

  @override
  Future<UserOtp?> getUserOtp(String userId, UserOtpTypeEnum type) async {
    final userOtpQuery = _usersDao.select(_usersDao.userOtpTable)
      ..where(
        (tbl) => tbl.userId.equals(userId) & tbl.type.equals(type.name),
      );

    final userOtpData = await userOtpQuery.getSingleOrNull();

    if (userOtpData == null) return null;

    return _userOtpOutputTransformer.transform(userOtpData);
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    final userData = await (_usersDao.select(_usersDao.userTable)
          ..where((tbl) => tbl.email.equals(email)))
        .getSingleOrNull();

    if (userData == null) return null;

    return _userOutputTransformer.transform(userData);
  }

  @override
  Future<User?> getUserByPhoneNumber(String phoneNumber) async {
    final userData = await (_usersDao.select(_usersDao.userTable)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
        .getSingleOrNull();

    if (userData == null) return null;

    return _userOutputTransformer.transform(userData);
  }

  @override
  Future<void> save(User user) {
    return _usersDao.update(_usersDao.userTable).replace(
          _userInputTransformer.transform(user),
        );
  }

  @override
  Future<void> invalidateUserOtp(String id) {
    return (_usersDao.delete(_usersDao.userOtpTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<User?> fromToken(String token) async {
    final payload = _jwtService.verifyAccessToken(token);

    if (payload == null) {
      return null;
    }

    final userId = payload.userId;

    return getUserById(userId);
  }

  static UsersRepo? _usersRepo;

  static Middleware middlewareProvider() {
    return provider<UsersRepo>(
      (context) {
        return _usersRepo ??= UsersRepo(
          usersDao: context.read<UsersDao>(),
          jwtService: context.read<JwtService>(),
          userOutputTransformer: UserOutputTransformer(),
          userInputTransformer: UserInputTransformer(),
          userOtpInputTransformer: UserOtpInputTransformer(),
          userOtpOutputTransformer: UserOtpOutputTransformer(),
        );
      },
    );
  }
}
