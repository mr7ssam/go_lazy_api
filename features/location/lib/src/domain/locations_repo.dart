import 'package:location/location_domain.dart';

/// Repository interface for managing saved locations.
/// Supports both user-level and group-level locations.
abstract class ILocationsRepo {
  // ========== User Locations ==========

  /// Get all saved locations for a specific user.
  /// Optionally filter by category and/or favorites only.
  Future<List<Location>> getUserLocations({
    required String userId,
    String? category,
    bool favoritesOnly = false,
  });

  /// Get a specific saved location by ID (user must own it).
  Future<Location?> getUserLocationById({
    required String userId,
    required int locationId,
  });

  /// Create a new saved location for a user.
  Future<Location> createUserLocation({
    required String userId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    String? category,
    bool isFavorite = false,
    String? notes,
  });

  Future<void> updateUserLocation(Location location);

  /// Delete a user location.
  Future<void> deleteUserLocation({
    required String userId,
    required int locationId,
  });

  // ========== Group Locations ==========

  /// Get all saved locations for a specific group.
  /// Optionally filter by category and/or favorites only.
  Future<List<Location>> getGroupLocations({
    required String groupId,
    String? category,
    bool favoritesOnly = false,
  });

  /// Get a specific saved location by ID (group must own it).
  Future<Location?> getGroupLocationById({
    required String groupId,
    required int locationId,
  });

  /// Create a new saved location for a group.
  Future<Location> createGroupLocation({
    required String groupId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    String? category,
    bool isFavorite = false,
    String? notes,
  });

  Future<void> updateGroupLocation(Location location);

  /// Delete a group location.
  Future<void> deleteGroupLocation({
    required String groupId,
    required int locationId,
  });
}
