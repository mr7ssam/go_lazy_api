import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:user/user_domain.dart';

class UserOtpInputTransformer {
  Insertable<UserOtpTableData> transform(UserOtp user) {
    return UserOtpTableCompanion(
      id: Value(user.id),
      userId: Value(user.userId),
      type: Value(user.type),
      code: Value(user.code),
      expiresAt: Value(user.expiresAt),
    );
  }

  List<Insertable<UserOtpTableData>> transformMany(List<UserOtp> users) {
    return users.map(transform).toList();
  }
}
