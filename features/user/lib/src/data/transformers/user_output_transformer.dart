import 'package:database/database.dart';
import 'package:user/user_domain.dart';

class UserOutputTransformer {
  User transform(UserTableData userData) {
    return User(
      id: userData.id,
      email: userData.email,
      phoneNumber: userData.phoneNumber,
      isEmailVerified: userData.isEmailVerified,
      isPhoneVerified: userData.isPhoneVerified,
      firstName: userData.firstName,
      lastName: userData.lastName,
      photoUrl: userData.photoUrl,
    );
  }

  List<User> transformMany(List<UserTableData> usersData) {
    return usersData.map(transform).toList();
  }
}
