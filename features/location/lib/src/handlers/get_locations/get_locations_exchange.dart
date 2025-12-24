import 'package:location/location_domain.dart';

/// Request to get saved locations with optional filters.
class GetLocationsRequest {
  const GetLocationsRequest({
    this.userId,
    this.groupId,
    this.category,
    this.favoritesOnly = false,
  });

  factory GetLocationsRequest.fromQueryParams(
    Map<String, String> params, {
    String? userId,
    String? groupId,
  }) {
    return GetLocationsRequest(
      userId: userId,
      groupId: groupId,
      category: params['category'],
      favoritesOnly: params['favoritesOnly'] == 'true',
    );
  }

  final String? userId;
  final String? groupId;
  final String? category;
  final bool favoritesOnly;
}

/// Response containing list of saved locations.
class GetLocationsResponse {
  const GetLocationsResponse({required this.locations});

  final List<Location> locations;

  Map<String, dynamic> toJson() {
    return {
      'locations': locations.map((loc) => loc.toJson()).toList(),
    };
  }
}
