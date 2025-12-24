import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';

part 'location_dao.g.dart';

@DriftAccessor(
  tables: [
    LocationTable,
  ],
)
class LocationDao extends DatabaseAccessor<Database> with _$LocationDaoMixin {
  LocationDao(super.attachedDatabase);

  static LocationDao? _database;

  static Middleware middlewareProvider() {
    return provider<LocationDao>(
      (context) => _database ??= LocationDao(
        context.read<Database>(),
      ),
    );
  }
}
