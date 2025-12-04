import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:group/group_domain.dart';

class GroupInputTransformer {
  static Insertable<GroupsTableData> transform(Group group) {
    return GroupsTableCompanion.insert(
      id: Value(group.id),
      name: group.name,
      description: Value(group.description),
      imageUrl: Value(group.imageUrl),
      createdBy: group.createdBy,
      createdAt: Value(group.createdAt),
      updatedAt: Value(group.updatedAt),
      isActive: Value(group.isActive),
    );
  }
}
