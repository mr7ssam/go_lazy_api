import 'package:database/database.dart';
import 'package:group/group_domain.dart';

class GroupOutputTransformer {
  static Group transform(GroupsTableData data) {
    return Group(
      id: data.id,
      name: data.name,
      description: data.description,
      imageUrl: data.imageUrl,
      createdBy: data.createdBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isActive: data.isActive,
    );
  }
}
