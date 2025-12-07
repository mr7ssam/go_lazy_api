class UpdateGroupRequest {
  const UpdateGroupRequest({
    required this.groupId,
    required this.userId,
    this.name,
    this.description,
    this.imageUrl,
  });

  factory UpdateGroupRequest.fromJson(Map<String, dynamic> json) =>
      UpdateGroupRequest(
        groupId: json['groupId'] as String,
        userId: json['userId'] as String,
        name: json['name'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  final String groupId;
  final String userId;
  final String? name;
  final String? description;
  final String? imageUrl;

  UpdateGroupRequest copyWith({
    String? groupId,
    String? userId,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return UpdateGroupRequest(
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class UpdateGroupResponse {
  const UpdateGroupResponse({
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
