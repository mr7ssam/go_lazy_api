import 'package:location/location_domain.dart';

class CreateLocationRequest {
  const CreateLocationRequest({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.userId,
    this.groupId,
    this.category,
    this.isFavorite = false,
    this.notes,
  });

  factory CreateLocationRequest.fromJson(
    Map<String, dynamic> json, {
    String? userId,
    String? groupId,
  }) {
    return CreateLocationRequest(
      userId: userId,
      groupId: groupId,
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      category: json['category'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      notes: json['notes'] as String?,
    );
  }

  final String? userId;
  final String? groupId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? category;
  final bool isFavorite;
  final String? notes;
}

class CreateLocationResponse {
  const CreateLocationResponse({required this.location});

  final Location location;

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
    };
  }
}
