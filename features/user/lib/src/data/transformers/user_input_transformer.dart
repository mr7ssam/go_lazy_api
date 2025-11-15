import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:user/user_domain.dart';

class UserInputTransformer {
  Insertable<UserTableData> transform(User user) {
    return UserTableCompanion(
      id: Value(user.id),
      email: Value(user.email),
      firstName: Value(user.firstName),
      lastName: Value(user.lastName),
      phoneNumber: Value(user.phoneNumber),
      photoUrl: Value(user.photoUrl),
      isEmailVerified: Value(user.isEmailVerified),
      isPhoneVerified: Value(user.isPhoneVerified),
    );
  }

  List<Insertable<UserTableData>> transformMany(List<User> users) {
    return users.map(transform).toList();
  }
}
