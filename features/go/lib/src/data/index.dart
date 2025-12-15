import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';

export 'repo/index.dart';
export 'transformers/index.dart';

extension HandlerUse on Handler {
  Handler registerGoDataMiddlewares() {
    return use(
      provider<IGoEventsRepo>(
        (context) => GoEventsRepo(
          goDao: context.read<GoDao>(),
        ),
      ),
    )
        .use(
          provider<IGoLocationsRepo>(
            (context) => GoLocationsRepo(
              goDao: context.read<GoDao>(),
            ),
          ),
        )
        .use(
          provider<IGoParticipantsRepo>(
            (context) => GoParticipantsRepo(
              goDao: context.read<GoDao>(),
            ),
          ),
        )
        .use(
          provider<IGoTasksRepo>(
            (context) => GoTasksRepo(
              goDao: context.read<GoDao>(),
            ),
          ),
        );
  }
}
