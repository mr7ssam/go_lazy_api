import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class RequestOtpHandler
    extends IHandler<RequestOtpRequest, RequestOtpResponse> {
  RequestOtpHandler({
    required IUsersRepo usersRepo,
    required TransactionManager transactionManager,
    required LocalizationService localization,
  })  : _usersRepo = usersRepo,
        _transactionManager = transactionManager,
        _localization = localization;

  final IUsersRepo _usersRepo;
  final TransactionManager _transactionManager;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<RequestOtpResponse>> handle(
    RequestOtpRequest request,
  ) async {
    final user = switch (request) {
      final EmailOtpRequest emailReq =>
        await _usersRepo.getUserByEmail(emailReq.email),
      final PhoneOtpRequest phoneReq =>
        await _usersRepo.getUserByPhoneNumber(phoneReq.phoneNumber),
      _ => throw UnsupportedError('Unsupported OTP request type'),
    };

    if (user == null) {
      return HandlerResult.failed(
        error: NotFoundError(
          message: _localization.translations.userNotFound,
        ),
      );
    }

    final otpType =
        request.isEmailRequest ? UserOtpTypeEnum.email : UserOtpTypeEnum.phone;

    late UserOtp createdOtp;

    await _transactionManager.runInTransaction(() async {
      if (request.isEmailRequest && !user.isEmailVerified) {
        await _usersRepo.save(user.copyWith(isEmailVerified: true));
      } else if (request.isPhoneRequest && !user.isPhoneVerified) {
        await _usersRepo.save(user.copyWith(isPhoneVerified: true));
      }

      createdOtp = await _usersRepo.createUserOtp(
        UserOtp.create(
          userId: user.id,
          type: otpType,
        ),
      );
    });

    return HandlerResult.success(
      data: RequestOtpResponse(
        message: request.isEmailRequest
            ? _localization.translations.otpSentEmail
            : _localization.translations.otpSentPhone,
        expiresAt: createdOtp.expiresAt,
      ),
    );
  }
}
