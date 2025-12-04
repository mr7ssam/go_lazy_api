class CreateGroupRequest {
  const CreateGroupRequest({
    required this.name,
    required this.userId,
    this.description,
    this.imageUrl,
  });

  factory CreateGroupRequest.fromJson(Map<String, dynamic> json) =>
      CreateGroupRequest(
        name: json['name'] as String,
        userId: json['userId'] as String,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  final String name;
  final String userId;
  final String? description;
  final String? imageUrl;

  CreateGroupRequest copyWith({
    String? name,
    String? userId,
    String? description,
    String? imageUrl,
  }) {
    return CreateGroupRequest(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class CreateGroupResponse {
  const CreateGroupResponse({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    this.description,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final String? description;
  final String? imageUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdBy': createdBy,
        'createdAt': createdAt.toIso8601String(),
        'description': description,
        'imageUrl': imageUrl,
      };
}
