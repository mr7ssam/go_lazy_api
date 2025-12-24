class Location {
  const Location({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
    this.userId,
    this.groupId,
    this.category,
    this.notes,
  }) : assert(
          (userId != null && groupId == null) ||
              (userId == null && groupId != null),
          'Location must belong to either a user or a group, not both',
        );

  final int id;
  final String? userId;
  final String? groupId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? category;
  final bool isFavorite;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isUserLocation => userId != null;

  bool get isGroupLocation => groupId != null;

  Location copyWith({
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? category,
    bool? isFavorite,
    String? notes,
  }) {
    return Location(
      id: id,
      userId: userId,
      groupId: groupId,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (userId != null) 'userId': userId,
      if (groupId != null) 'groupId': groupId,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      if (category != null) 'category': category,
      'isFavorite': isFavorite,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
