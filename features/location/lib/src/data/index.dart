import 'package:common/common.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:location/location_data.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';

extension LocationDataMiddleware on Handler {
  Handler registerLocationDataMiddlewares() {
    return use(
      provider<ILocationsRepo>(
        (context) => LocationsRepo(
          locationDao: context.read<LocationDao>(),
        ),
      ),
    );
  }

  Handler registerLocationHandlersMiddlewares() {
    return use(
      provider<CreateLocationHandler>(
        (context) => CreateLocationHandler(
          locationsRepo: context.read<ILocationsRepo>(),
          localization: context.read<LocalizationService>(),
        ),
      ),
    )
        .use(
          provider<GetLocationsHandler>(
            (context) => GetLocationsHandler(
              locationsRepo: context.read<ILocationsRepo>(),
            ),
          ),
        )
        .use(
          provider<UpdateLocationHandler>(
            (context) => UpdateLocationHandler(
              locationsRepo: context.read<ILocationsRepo>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<DeleteLocationHandler>(
            (context) => DeleteLocationHandler(
              locationsRepo: context.read<ILocationsRepo>(),
            ),
          ),
        );
  }
}
