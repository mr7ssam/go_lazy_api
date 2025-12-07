class GetGroupRequest {
  const GetGroupRequest({
    required this.groupId,
    required this.userId,
  });

  final String groupId;
  final String userId;

  GetGroupRequest copyWith({
    String? groupId,
    String? userId,
  }) {
    return GetGroupRequest(
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
    );
  }
}

class GetGroupResponse {
  const GetGroupResponse({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.memberCount,
    this.description,
    this.imageUrl,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final int memberCount;
  final String? description;
  final String? imageUrl;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdBy': createdBy,
        'createdAt': createdAt.toIso8601String(),
        'memberCount': memberCount,
        'description': description,
        'imageUrl': imageUrl,
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
