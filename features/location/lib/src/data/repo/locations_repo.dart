import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:location/location_data.dart';
import 'package:location/location_domain.dart';

class LocationsRepo implements ILocationsRepo {
  LocationsRepo({required LocationDao locationDao})
      : _locationDao = locationDao;

  final LocationDao _locationDao;

  @override
  Future<List<Location>> getUserLocations({
    required String userId,
    String? category,
    bool favoritesOnly = false,
  }) async {
    var query = _locationDao.select(_locationDao.locationTable)
      ..where((tbl) => tbl.userId.equals(userId));

    if (category != null) {
      query = query..where((tbl) => tbl.category.equals(category));
    }

    if (favoritesOnly) {
      query = query..where((tbl) => tbl.isFavorite.equals(true));
    }

    query = query
      ..orderBy([
        (tbl) => OrderingTerm.desc(tbl.isFavorite),
        (tbl) => OrderingTerm.desc(tbl.createdAt),
      ]);

    final results = await query.get();
    return LocationOutputTransformer.toEntities(results);
  }

  @override
  Future<Location?> getUserLocationById({
    required String userId,
    required int locationId,
  }) async {
    final query = _locationDao.select(_locationDao.locationTable)
      ..where((tbl) => tbl.id.equals(locationId) & tbl.userId.equals(userId));

    final result = await query.getSingleOrNull();
    return result != null ? LocationOutputTransformer.toEntity(result) : null;
  }

  @override
  Future<Location> createUserLocation({
    required String userId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    String? category,
    bool isFavorite = false,
    String? notes,
  }) async {
    final companion = LocationInputTransformer.toUserCompanion(
      userId: userId,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      category: category,
      isFavorite: isFavorite,
      notes: notes,
    );

    final id =
        await _locationDao.into(_locationDao.locationTable).insert(companion);
    final created = await getUserLocationById(userId: userId, locationId: id);
    return created!;
  }

  @override
  Future<void> updateUserLocation(Location location) async {
    await _locationDao.update(_locationDao.locationTable).replace(
          LocationInputTransformer.toTableData(location),
        );
  }

  @override
  Future<void> deleteUserLocation({
    required String userId,
    required int locationId,
  }) async {
    await (_locationDao.delete(_locationDao.locationTable)
          ..where(
            (tbl) => tbl.id.equals(locationId) & tbl.userId.equals(userId),
          ))
        .go();
  }

  @override
  Future<List<Location>> getGroupLocations({
    required String groupId,
    String? category,
    bool favoritesOnly = false,
  }) async {
    var query = _locationDao.select(_locationDao.locationTable)
      ..where((tbl) => tbl.groupId.equals(groupId));

    if (category != null) {
      query = query..where((tbl) => tbl.category.equals(category));
    }

    if (favoritesOnly) {
      query = query..where((tbl) => tbl.isFavorite.equals(true));
    }

    query = query
      ..orderBy([
        (tbl) => OrderingTerm.desc(tbl.isFavorite),
        (tbl) => OrderingTerm.desc(tbl.createdAt),
      ]);

    final results = await query.get();
    return LocationOutputTransformer.toEntities(results);
  }

  @override
  Future<Location?> getGroupLocationById({
    required String groupId,
    required int locationId,
  }) async {
    final query = _locationDao.select(_locationDao.locationTable)
      ..where((tbl) => tbl.id.equals(locationId) & tbl.groupId.equals(groupId));

    final result = await query.getSingleOrNull();
    return result != null ? LocationOutputTransformer.toEntity(result) : null;
  }

  @override
  Future<Location> createGroupLocation({
    required String groupId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    String? category,
    bool isFavorite = false,
    String? notes,
  }) async {
    final companion = LocationInputTransformer.toGroupCompanion(
      groupId: groupId,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      category: category,
      isFavorite: isFavorite,
      notes: notes,
    );

    final id =
        await _locationDao.into(_locationDao.locationTable).insert(companion);
    final created =
        await getGroupLocationById(groupId: groupId, locationId: id);
    return created!;
  }

  @override
  Future<void> updateGroupLocation(Location location) async {
    await _locationDao.update(_locationDao.locationTable).replace(
          LocationInputTransformer.toTableData(location),
        );
  }

  @override
  Future<void> deleteGroupLocation({
    required String groupId,
    required int locationId,
  }) async {
    await (_locationDao.delete(_locationDao.locationTable)
          ..where(
            (tbl) => tbl.id.equals(locationId) & tbl.groupId.equals(groupId),
          ))
        .go();
  }
}
