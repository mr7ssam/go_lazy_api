import 'package:common/common.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';

/// Handler for deleting a saved location (user or group).
class DeleteLocationHandler
    extends IHandler<DeleteLocationRequest, DeleteLocationResponse> {
  DeleteLocationHandler({
    required this.locationsRepo,
  });

  final ILocationsRepo locationsRepo;

  @override
  Future<HandlerResult<DeleteLocationResponse>> handle(
    DeleteLocationRequest request,
  ) async {
    if ((request.userId == null && request.groupId == null) ||
        (request.userId != null && request.groupId != null)) {
      return HandlerResult.failed(
        error: BadRequestError(
          message: 'Must specify either userId or groupId, not both',
        ),
      );
    }

    try {
      if (request.userId != null) {
        await locationsRepo.deleteUserLocation(
          userId: request.userId!,
          locationId: request.locationId,
        );
      } else {
        await locationsRepo.deleteGroupLocation(
          groupId: request.groupId!,
          locationId: request.locationId,
        );
      }

      return const HandlerResult.success(
        data: DeleteLocationResponse(
          message: 'Location deleted successfully',
        ),
      );
    } on NotFoundError catch (e) {
      return HandlerResult.failed(error: e);
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(message: e.toString()),
      );
    }
  }
}
