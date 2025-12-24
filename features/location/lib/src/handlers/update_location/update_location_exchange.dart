import 'package:location/location_domain.dart';

/// Request to update a saved location.
class UpdateLocationRequest {
  const UpdateLocationRequest({
    required this.locationId,
    this.userId,
    this.groupId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.category,
    this.isFavorite,
    this.notes,
  });

  factory UpdateLocationRequest.fromJson(
    Map<String, dynamic> json, {
    required int locationId,
    String? userId,
    String? groupId,
  }) {
    return UpdateLocationRequest(
      locationId: locationId,
      userId: userId,
      groupId: groupId,
      name: json['name'] as String?,
      address: json['address'] as String?,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      category: json['category'] as String?,
      isFavorite: json['isFavorite'] as bool?,
      notes: json['notes'] as String?,
    );
  }

  final int locationId;
  final String? userId;
  final String? groupId;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? category;
  final bool? isFavorite;
  final String? notes;
}

/// Response containing the updated saved location.
class UpdateLocationResponse {
  const UpdateLocationResponse({required this.location});

  final Location location;

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
    };
  }
}
