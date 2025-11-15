import 'package:common/common.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

export 'create_user/index.dart';
export 'login/index.dart';
export 'profile/index.dart';
export 'refresh_token/index.dart';
export 'request_otp/index.dart';
export 'upload_image/index.dart';

extension HandlerUse on Handler {
  Handler registerUserHandlersMiddlewares() {
    return use(
      provider<CreateUserHandler>(
        (context) => CreateUserHandler(
          transactionManager: context.read<TransactionManager>(),
          usersRepo: context.read<IUsersRepo>(),
          localization: context.read<LocalizationService>(),
        ),
      ),
    )
        .use(
          provider<LoginHandler>(
            (context) => LoginHandler(
              transactionManager: context.read<TransactionManager>(),
              usersRepo: context.read<IUsersRepo>(),
              jwtService: context.read<JwtService>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<GetUserHandler>(
            (context) => GetUserHandler(
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<RefreshTokenHandler>(
            (context) => RefreshTokenHandler(
              jwtService: context.read<JwtService>(),
            ),
          ),
        )
        .use(
          provider<RequestOtpHandler>(
            (context) => RequestOtpHandler(
              transactionManager: context.read<TransactionManager>(),
              usersRepo: context.read<IUsersRepo>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<UploadUserPhotoHandler>(
            (context) => UploadUserPhotoHandler(
              storageService: context.read<IStorageService>(),
              usersRepo: context.read<IUsersRepo>(),
            ),
          ),
        );
  }
}
