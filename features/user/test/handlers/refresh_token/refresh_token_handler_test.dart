import 'package:common/common.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

class _MockJwtService extends Mock implements JwtService {}

void main() {
  late _MockJwtService jwtService;
  late RefreshTokenHandler handler;

  setUpAll(() {
    final claimsFallback = <String, dynamic>{};
    registerFallbackValue(claimsFallback);
  });

  setUp(() {
    jwtService = _MockJwtService();
    handler = RefreshTokenHandler(jwtService: jwtService);
  });

  group('RefreshTokenHandler', () {
    test('returns UnauthorizedError when refresh token is invalid', () async {
      when(
        () => jwtService.verifyRefreshToken('invalid'),
      ).thenReturn(null);

      final result = await handler.handle(
        const RefreshTokenRequest(refreshToken: 'invalid'),
      );

      expect(result, isA<HandlerResult<RefreshTokenResponse>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
          expect(error.statusCode, equals(401));
          expect(error.message, contains('Invalid or expired refresh token'));
        },
      );
      verifyNever(
        () => jwtService.generateTokens(
          userId: any(named: 'userId'),
          additionalClaims: any(named: 'additionalClaims'),
        ),
      );
    });

    test('returns new tokens when refresh token is valid', () async {
      final payload = TokenPayload(
        userId: 'user-1',
        type: 'refresh',
        issuedAt: DateTime.utc(2025),
        expiresAt: DateTime.utc(2025, 1, 2),
        additionalClaims: {'email': 'user@example.com'},
      );

      when(() => jwtService.verifyRefreshToken('valid')).thenReturn(payload);
      when(
        () => jwtService.generateTokens(
          userId: payload.userId,
          additionalClaims: payload.additionalClaims,
        ),
      ).thenReturn(
        const TokenPair(
          accessToken: 'new-access',
          refreshToken: 'new-refresh',
          expiresIn: 900,
        ),
      );

      final result = await handler.handle(
        const RefreshTokenRequest(refreshToken: 'valid'),
      );

      expect(result, isA<HandlerResult<RefreshTokenResponse>>());
      result.when(
        success: (response) {
          expect(response.accessToken, equals('new-access'));
          expect(response.refreshToken, equals('new-refresh'));
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );
    });
  });
}
