import 'package:dart_frog/dart_frog.dart';
import 'package:user/user_data.dart';

export 'jwt/index.dart';
export 'repo/index.dart';
export 'transformers/index.dart';

extension HandlerUse on Handler {
  Handler registerUserDataMiddlewares() {
    return use(
      jwtAuthMiddleware(),
    ).use(
      UsersRepo.middlewareProvider(),
    );
  }
}
