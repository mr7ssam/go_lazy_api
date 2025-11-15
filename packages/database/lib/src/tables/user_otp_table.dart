import 'package:database/src/tables/index.dart' show UserTable;
import 'package:drift/drift.dart';
import 'package:user/user_domain.dart';
import 'package:uuid/uuid.dart';

class UserOtpTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get userId => text().references(UserTable, #id)();

  TextColumn get code => text()();

  TextColumn get type => textEnum<UserOtpTypeEnum>()();

  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'user_otps';
}
