import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';

class GoEventInputTransformer {
  static Insertable<GoEventsTableData> transform(GoEvent event) {
    return GoEventsTableCompanion(
      id: Value(event.id),
      title: Value(event.title),
      description: Value(event.description),
      locationId: Value(event.locationId),
      startDate: Value(event.startDate),
      endDate: Value(event.endDate),
      groupId: Value(event.groupId),
      coverImageUrl: Value(event.coverImageUrl),
      createdBy: Value(event.createdBy),
      createdAt: Value(event.createdAt),
      updatedAt: Value(event.updatedAt),
      isActive: Value(event.isActive),
      visibility: Value(event.visibility),
    );
  }
}

class GoEventOutputTransformer {
  static GoEvent transform(GoEventsTableData data) {
    return GoEvent(
      id: data.id,
      title: data.title,
      description: data.description,
      locationId: data.locationId,
      startDate: data.startDate,
      endDate: data.endDate,
      groupId: data.groupId,
      coverImageUrl: data.coverImageUrl,
      createdBy: data.createdBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isActive: data.isActive,
      visibility: data.visibility,
    );
  }
}
