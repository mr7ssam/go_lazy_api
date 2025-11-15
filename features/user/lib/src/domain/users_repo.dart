import 'package:user/user_domain.dart';

abstract class IUsersRepo {
  Future<User> createUser(User user);
  Future<void> save(User user);
  Future<User?> getUserById(String id);
  Future<User?> getUserByEmail(String email);
  Future<User?> getUserByPhoneNumber(String phoneNumber);
  Future<User?> fromToken(String token);
  Future<UserOtp> createUserOtp(UserOtp userOtp);
  Future<UserOtp?> getUserOtp(String userId, UserOtpTypeEnum type);
  Future<void> invalidateUserOtp(String id);
}
