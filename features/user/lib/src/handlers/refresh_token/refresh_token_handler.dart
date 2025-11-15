import 'package:common/common.dart';
import 'package:user/user_handlers.dart';

class RefreshTokenHandler
    extends IHandler<RefreshTokenRequest, RefreshTokenResponse> {
  RefreshTokenHandler({
    required JwtService jwtService,
  }) : _jwtService = jwtService;

  final JwtService _jwtService;

  @override
  Future<HandlerResult<RefreshTokenResponse>> handle(
    RefreshTokenRequest request,
  ) async {
    final payload = _jwtService.verifyRefreshToken(request.refreshToken);

    if (payload == null) {
      return HandlerResult.failed(
        error: UnauthorizedError(
          message: 'Invalid or expired refresh token',
        ),
      );
    }

    final tokens = _jwtService.generateTokens(
      userId: payload.userId,
      additionalClaims: payload.additionalClaims,
    );

    return HandlerResult.success(
      data: RefreshTokenResponse(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      ),
    );
  }
}
