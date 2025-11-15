import 'package:database/database.dart';
import 'package:user/user_domain.dart';

class UserOtpOutputTransformer {
  UserOtp transform(UserOtpTableData userData) {
    return UserOtp(
      id: userData.id,
      userId: userData.userId,
      type: userData.type,
      code: userData.code,
      expiresAt: userData.expiresAt,
    );
  }

  List<UserOtp> transformMany(List<UserOtpTableData> usersData) {
    return usersData.map(transform).toList();
  }
}
