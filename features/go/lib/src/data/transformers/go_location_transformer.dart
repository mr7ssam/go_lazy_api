import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';

class GoLocationInputTransformer {
  static Insertable<GoLocationsTableData> transform(GoLocation location) {
    return GoLocationsTableCompanion(
      id: Value(location.id),
      name: Value(location.name),
      address: Value(location.address),
      latitude: Value(location.latitude),
      longitude: Value(location.longitude),
      googleMapsUrl: Value(location.googleMapsUrl),
      createdBy: Value(location.createdBy),
      createdAt: Value(location.createdAt),
      updatedAt: Value(location.updatedAt),
      isActive: Value(location.isActive),
    );
  }
}

class GoLocationOutputTransformer {
  static GoLocation transform(GoLocationsTableData data) {
    return GoLocation(
      id: data.id,
      name: data.name,
      address: data.address,
      latitude: data.latitude,
      longitude: data.longitude,
      googleMapsUrl: data.googleMapsUrl,
      createdBy: data.createdBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isActive: data.isActive,
    );
  }
}
