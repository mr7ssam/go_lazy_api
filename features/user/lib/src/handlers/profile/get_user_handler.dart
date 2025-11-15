import 'package:common/common.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class GetUserHandler extends IHandler<User?, GetUserResponse> {
  GetUserHandler({
    required LocalizationService localization,
  }) : _localization = localization;

  final LocalizationService _localization;

  @override
  Future<HandlerResult<GetUserResponse>> handle(User? user) async {
    if (user == null) {
      return HandlerResult.failed(
        error: NotFoundError(
          message: _localization.translations.userNotFound,
        ),
      );
    }

    return HandlerResult.success(
      data: GetUserResponse(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        isEmailVerified: user.isEmailVerified,
        isPhoneVerified: user.isPhoneVerified,
      ),
    );
  }
}
