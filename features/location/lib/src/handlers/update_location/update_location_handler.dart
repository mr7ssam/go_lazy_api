import 'package:common/common.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';
import 'package:postgres/postgres.dart';

class UpdateLocationHandler
    extends IHandler<UpdateLocationRequest, UpdateLocationResponse> {
  UpdateLocationHandler({
    required this.locationsRepo,
    required this.localization,
  });

  final ILocationsRepo locationsRepo;
  final LocalizationService localization;

  @override
  Future<HandlerResult<UpdateLocationResponse>> handle(
    UpdateLocationRequest request,
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
      final Location? existing;

      if (request.userId != null) {
        existing = await locationsRepo.getUserLocationById(
          userId: request.userId!,
          locationId: request.locationId,
        );
      } else {
        existing = await locationsRepo.getGroupLocationById(
          groupId: request.groupId!,
          locationId: request.locationId,
        );
      }

      if (existing == null) {
        return HandlerResult.failed(
          error: NotFoundError(message: 'Location not found'),
        );
      }

      final updated = existing.copyWith(
        name: request.name,
        address: request.address,
        latitude: request.latitude,
        longitude: request.longitude,
        category: request.category,
        isFavorite: request.isFavorite,
        notes: request.notes,
      );

      if (request.userId != null) {
        await locationsRepo.updateUserLocation(updated);
      } else {
        await locationsRepo.updateGroupLocation(updated);
      }

      return HandlerResult.success(
        data: UpdateLocationResponse(location: updated),
      );
    } on UniqueViolationException catch (_) {
      return HandlerResult.failed(
        error: ConflictError(
          message: localization.translations.locationNameAlreadyExists,
        ),
      );
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(message: e.toString()),
      );
    }
  }
}
