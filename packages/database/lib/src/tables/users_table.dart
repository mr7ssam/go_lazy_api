import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class UserTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get firstName => text().customConstraint('NOT NULL')();

  TextColumn get lastName => text().customConstraint('NOT NULL')();

  TextColumn get email =>
      text().withLength(min: 1, max: 50).customConstraint('NOT NULL')();

  TextColumn get phoneNumber => text().customConstraint('NOT NULL')();

  TextColumn? get photoUrl => text().nullable()();

  BoolColumn get isEmailVerified =>
      boolean().customConstraint('NOT NULL DEFAULT false')();

  BoolColumn get isPhoneVerified =>
      boolean().customConstraint('NOT NULL DEFAULT false')();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {email},
        {phoneNumber},
      ];

  @override
  String get tableName => 'users';
}
