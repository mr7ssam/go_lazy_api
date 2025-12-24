import 'package:common/common.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';

/// Handler for getting saved locations (user or group).
class GetLocationsHandler
    extends IHandler<GetLocationsRequest, GetLocationsResponse> {
  GetLocationsHandler({
    required this.locationsRepo,
  });

  final ILocationsRepo locationsRepo;

  @override
  Future<HandlerResult<GetLocationsResponse>> handle(
    GetLocationsRequest request,
  ) async {
    // Ensure exactly one of userId or groupId is provided
    if ((request.userId == null && request.groupId == null) ||
        (request.userId != null && request.groupId != null)) {
      return HandlerResult.failed(
        error: BadRequestError(
          message: 'Must specify either userId or groupId, not both',
        ),
      );
    }

    try {
      final List<Location> locations;

      if (request.userId != null) {
        locations = await locationsRepo.getUserLocations(
          userId: request.userId!,
          category: request.category,
          favoritesOnly: request.favoritesOnly,
        );
      } else {
        locations = await locationsRepo.getGroupLocations(
          groupId: request.groupId!,
          category: request.category,
          favoritesOnly: request.favoritesOnly,
        );
      }

      return HandlerResult.success(
        data: GetLocationsResponse(locations: locations),
      );
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(message: e.toString()),
      );
    }
  }
}
