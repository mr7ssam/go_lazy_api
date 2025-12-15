import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';

part 'go_dao.g.dart';

@DriftAccessor(
  tables: [
    GoEventsTable,
    GoLocationsTable,
    GoParticipantsTable,
    GoTasksTable,
  ],
)
class GoDao extends DatabaseAccessor<Database> with _$GoDaoMixin {
  GoDao(super.attachedDatabase);

  static GoDao? _database;

  static Middleware middlewareProvider() {
    return provider<GoDao>(
      (context) => _database ??= GoDao(
        context.read<Database>(),
      ),
    );
  }
}
