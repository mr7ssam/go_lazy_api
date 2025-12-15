import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';

class GoLocationsRepo implements IGoLocationsRepo {
  GoLocationsRepo({required GoDao goDao}) : _goDao = goDao;

  final GoDao _goDao;

  @override
  Future<GoLocation> createLocation(GoLocation location) async {
    final companion = GoLocationInputTransformer.transform(location);
    final result =
        await _goDao.into(_goDao.goLocationsTable).insertReturning(companion);

    return GoLocationOutputTransformer.transform(result);
  }

  @override
  Future<void> updateLocation(GoLocation location) async {
    final companion = GoLocationInputTransformer.transform(location);

    await (_goDao.update(_goDao.goLocationsTable)
          ..where((tbl) => tbl.id.equals(location.id)))
        .write(companion);
  }

  @override
  Future<GoLocation?> getLocationById(String id) async {
    final query = _goDao.select(_goDao.goLocationsTable)
      ..where((tbl) => tbl.id.equals(id) & tbl.isActive.equals(true));
    final result = await query.getSingleOrNull();

    return result != null
        ? GoLocationOutputTransformer.transform(result)
        : null;
  }

  @override
  Future<List<GoLocation>> getUserLocations(String userId) async {
    final query = _goDao.select(_goDao.goLocationsTable)
      ..where(
        (tbl) => tbl.createdBy.equals(userId) & tbl.isActive.equals(true),
      );

    final results = await query.get();

    return results.map(GoLocationOutputTransformer.transform).toList();
  }

  @override
  Future<void> deleteLocation(String id) async {
    await (_goDao.update(_goDao.goLocationsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(const GoLocationsTableCompanion(isActive: Value(false)));
  }
}
