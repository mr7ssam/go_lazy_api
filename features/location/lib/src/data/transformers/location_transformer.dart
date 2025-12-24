import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:location/location_domain.dart';

class LocationInputTransformer {
  static LocationTableCompanion toUserCompanion({
    required String userId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    String? category,
    bool isFavorite = false,
    String? notes,
  }) {
    return LocationTableCompanion.insert(
      userId: Value(userId),
      groupId: const Value(null),
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      category: Value(category),
      isFavorite: Value(isFavorite),
      notes: Value(notes),
    );
  }

  static LocationTableCompanion toGroupCompanion({
    required String groupId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    String? category,
    bool isFavorite = false,
    String? notes,
  }) {
    return LocationTableCompanion.insert(
      userId: const Value(null),
      groupId: Value(groupId),
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      category: Value(category),
      isFavorite: Value(isFavorite),
      notes: Value(notes),
    );
  }

  static LocationTableData toTableData(Location entity) {
    return LocationTableData(
      id: entity.id,
      userId: entity.userId,
      groupId: entity.groupId,
      name: entity.name,
      address: entity.address,
      latitude: entity.latitude,
      longitude: entity.longitude,
      category: entity.category,
      isFavorite: entity.isFavorite,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: DateTime.now().toUtc(),
    );
  }
}

class LocationOutputTransformer {
  static Location toEntity(LocationTableData data) {
    return Location(
      id: data.id,
      userId: data.userId,
      groupId: data.groupId,
      name: data.name,
      address: data.address,
      latitude: data.latitude,
      longitude: data.longitude,
      category: data.category,
      isFavorite: data.isFavorite,
      notes: data.notes,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  static List<Location> toEntities(List<LocationTableData> dataList) {
    return dataList.map(toEntity).toList();
  }
}
