import 'package:common/common.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';
import 'package:postgres/postgres.dart';

class CreateLocationHandler
    extends IHandler<CreateLocationRequest, CreateLocationResponse> {
  CreateLocationHandler({
    required this.locationsRepo,
    required this.localization,
  });

  final ILocationsRepo locationsRepo;
  final LocalizationService localization;

  @override
  Future<HandlerResult<CreateLocationResponse>> handle(
    CreateLocationRequest request,
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
      final Location location;

      if (request.userId != null) {
        location = await locationsRepo.createUserLocation(
          userId: request.userId!,
          name: request.name,
          address: request.address,
          latitude: request.latitude,
          longitude: request.longitude,
          category: request.category,
          isFavorite: request.isFavorite,
          notes: request.notes,
        );
      } else {
        location = await locationsRepo.createGroupLocation(
          groupId: request.groupId!,
          name: request.name,
          address: request.address,
          latitude: request.latitude,
          longitude: request.longitude,
          category: request.category,
          isFavorite: request.isFavorite,
          notes: request.notes,
        );
      }

      return HandlerResult.success(
        data: CreateLocationResponse(location: location),
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
