import 'package:go/go_domain.dart';

abstract class IGoLocationsRepo {
  Future<GoLocation> createLocation(GoLocation location);
  Future<void> updateLocation(GoLocation location);
  Future<GoLocation?> getLocationById(String id);
  Future<List<GoLocation>> getUserLocations(String userId);
  Future<void> deleteLocation(String id);
}
