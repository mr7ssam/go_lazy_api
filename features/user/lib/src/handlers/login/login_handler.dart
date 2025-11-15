import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class LoginHandler extends IHandler<LoginRequest, LoginResponse> {
  LoginHandler({
    required IUsersRepo usersRepo,
    required TransactionManager transactionManager,
    required JwtService jwtService,
    required LocalizationService localization,
  })  : _usersRepo = usersRepo,
        _transactionManager = transactionManager,
        _jwtService = jwtService,
        _localization = localization;

  final IUsersRepo _usersRepo;
  final TransactionManager _transactionManager;
  final JwtService _jwtService;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<LoginResponse>> handle(LoginRequest request) async {
    final user = switch (request) {
      final EmailLoginRequest emailReq =>
        await _usersRepo.getUserByEmail(emailReq.email),
      final PhoneLoginRequest phoneReq =>
        await _usersRepo.getUserByPhoneNumber(phoneReq.phoneNumber),
      _ => throw UnsupportedError('Unsupported login request type'),
    };

    if (user == null) {
      return HandlerResult.failed(
        error: NotFoundError(
          message: _localization.translations.userNotFound,
        ),
      );
    }

    final otp = await _usersRepo.getUserOtp(
      user.id,
      request.isEmailLogin ? UserOtpTypeEnum.email : UserOtpTypeEnum.phone,
    );

    if (otp == null || otp.code != request.otp) {
      return HandlerResult.failed(
        error: BadRequestError(
          message: _localization.translations.invalidOtp,
        ),
      );
    }

    await _transactionManager.runInTransaction(
      () async {
        var updatedUser = user;

        if (request.isEmailLogin && !user.isEmailVerified) {
          updatedUser = updatedUser.copyWith(isEmailVerified: true);
        } else if (request.isPhoneLogin && !user.isPhoneVerified) {
          updatedUser = updatedUser.copyWith(isPhoneVerified: true);
        }

        await _transactionManager.runInTransaction(
          () async {
            await Future.wait([
              _usersRepo.save(updatedUser),
              _usersRepo.invalidateUserOtp(otp.id),
            ]);
          },
        );
      },
    );

    final tokens = _jwtService.generateTokens(
      userId: user.id,
      additionalClaims: {
        'email': user.email,
        'phone': user.phoneNumber,
      },
    );

    return HandlerResult.success(
      data: LoginResponse(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      ),
    );
  }
}
