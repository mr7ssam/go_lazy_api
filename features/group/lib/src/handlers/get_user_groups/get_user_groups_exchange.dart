class GetUserGroupsRequest {
  const GetUserGroupsRequest({
    required this.userId,
  });

  factory GetUserGroupsRequest.fromJson(Map<String, dynamic> json) =>
      GetUserGroupsRequest(
        userId: json['userId'] as String,
      );

  final String userId;
}

class GroupSummary {
  const GroupSummary({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    this.description,
    this.imageUrl,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final String? description;
  final String? imageUrl;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdBy': createdBy,
        'createdAt': createdAt.toIso8601String(),
        'description': description,
        'imageUrl': imageUrl,
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class GetUserGroupsResponse {
  const GetUserGroupsResponse({
    required this.groups,
  });

  final List<GroupSummary> groups;

  Map<String, dynamic> toJson() => {
        'groups': groups.map((g) => g.toJson()).toList(),
      };
}
