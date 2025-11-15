import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';

part 'user_dao.g.dart';

@DriftAccessor(
  tables: [UserTable, UserOtpTable],
)
class UsersDao extends DatabaseAccessor<Database> with _$UsersDaoMixin {
  UsersDao(super.attachedDatabase);

  static UsersDao? _database;

  static Middleware middlewareProvider() {
    return provider<UsersDao>(
      (context) => _database ??= UsersDao(
        context.read<Database>(),
      ),
    );
  }
}
