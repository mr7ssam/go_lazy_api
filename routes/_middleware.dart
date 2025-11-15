import 'package:common/common.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:user/user_data.dart';

Handler middleware(Handler handler) {
  return handler
      .use(localizationMiddleware())
      .registerUserDataMiddlewares()
      .use(
        provider<JwtService>(
          (_) => JwtService.fromEnvironment(),
        ),
      )
      .registerDatabaseMiddlewares()
      .use(
        provider<IStorageService>(
          (_) => CloudinaryStorageService.instance(),
        ),
      );
}
