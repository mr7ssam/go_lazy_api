import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:go/go_domain.dart';
import 'package:postgres/postgres.dart' as pg;
import 'package:user/user_domain.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    UserTable,
    UserOtpTable,
    GroupsTable,
    GroupMembersTable,
    GroupInvitesTable,
    GoLocationsTable,
    GoEventsTable,
    GoParticipantsTable,
    GoRecurrenceRulesTable,
    GoRemindersTable,
    GoTasksTable,
    LocationTable,
  ],
  daos: [UsersDao, GroupsDao, GoDao, LocationDao],
)
class Database extends _$Database {
  Database([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return PgDatabase(
      settings: const pg.ConnectionSettings(
        sslMode: pg.SslMode.require,
      ),
      endpoint: pg.Endpoint(
        host: Platform.environment['DATABASE_HOST']!,
        database: Platform.environment['DATABASE_NAME']!,
        username: Platform.environment['DATABASE_USER'],
        password: Platform.environment['DATABASE_PASSWORD'],
      ),
    );
  }

  static Database? _database;

  static Middleware middlewareProvider() {
    return provider<Database>(
      (context) => _database ??= Database(),
    );
  }
}

extension DatabaseUse on Handler {
  Handler registerDatabaseMiddlewares() {
    return use(
      TransactionManager.middlewareProvider(),
    )
        .use(
          UsersDao.middlewareProvider(),
        )
        .use(
          GroupsDao.middlewareProvider(),
        )
        .use(
          LocationDao.middlewareProvider(),
        )
        .use(
          Database.middlewareProvider(),
        );
  }
}
