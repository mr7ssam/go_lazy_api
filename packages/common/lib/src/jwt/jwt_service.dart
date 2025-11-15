import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtService {
  JwtService({
    required String accessTokenSecret,
    required String refreshTokenSecret,
    this.accessTokenExpirationMinutes = 15,
    this.refreshTokenExpirationDays = 7,
  })  : _accessTokenSecret = accessTokenSecret,
        _refreshTokenSecret = refreshTokenSecret;

  factory JwtService.fromEnvironment() {
    if (_instance != null) {
      return _instance!;
    }

    final accessSecret = Platform.environment['JWT_ACCESS_SECRET'];
    final refreshSecret = Platform.environment['JWT_REFRESH_SECRET'];

    if (accessSecret == null || accessSecret.isEmpty) {
      throw Exception('JWT_ACCESS_SECRET environment variable is required');
    }

    if (refreshSecret == null || refreshSecret.isEmpty) {
      throw Exception('JWT_REFRESH_SECRET environment variable is required');
    }

    final accessExpiration = int.tryParse(
          Platform.environment['JWT_ACCESS_EXPIRATION_MINUTES'] ?? '15',
        ) ??
        15;
    final refreshExpiration = int.tryParse(
          Platform.environment['JWT_REFRESH_EXPIRATION_DAYS'] ?? '7',
        ) ??
        7;

    _instance = JwtService(
      accessTokenSecret: accessSecret,
      refreshTokenSecret: refreshSecret,
      accessTokenExpirationMinutes: accessExpiration,
      refreshTokenExpirationDays: refreshExpiration,
    );

    return _instance!;
  }

  static JwtService? _instance;

  final String _accessTokenSecret;
  final String _refreshTokenSecret;
  final int accessTokenExpirationMinutes;
  final int refreshTokenExpirationDays;

  TokenPair generateTokens({
    required String userId,
    Map<String, dynamic>? additionalClaims,
  }) {
    final now = DateTime.now();

    final accessToken = _generateToken(
      userId: userId,
      secret: _accessTokenSecret,
      expiresAt: now.add(Duration(minutes: accessTokenExpirationMinutes)),
      additionalClaims: additionalClaims,
      tokenType: 'access',
    );

    final refreshToken = _generateToken(
      userId: userId,
      secret: _refreshTokenSecret,
      expiresAt: now.add(Duration(days: refreshTokenExpirationDays)),
      tokenType: 'refresh',
    );

    return TokenPair(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: accessTokenExpirationMinutes * 60, // in seconds
    );
  }

  String _generateToken({
    required String userId,
    required String secret,
    required DateTime expiresAt,
    required String tokenType,
    Map<String, dynamic>? additionalClaims,
  }) {
    final jwt = JWT(
      {
        'sub': userId,
        'type': tokenType,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp': expiresAt.millisecondsSinceEpoch ~/ 1000,
        if (additionalClaims != null) ...additionalClaims,
      },
    );

    return jwt.sign(SecretKey(secret));
  }

  TokenPayload? verifyAccessToken(String token) {
    return _verifyToken(token, _accessTokenSecret, 'access');
  }

  TokenPayload? verifyRefreshToken(String token) {
    return _verifyToken(token, _refreshTokenSecret, 'refresh');
  }

  TokenPayload? _verifyToken(
    String token,
    String secret,
    String expectedType,
  ) {
    try {
      final jwt = JWT.verify(token, SecretKey(secret));
      final payload = jwt.payload as Map<String, dynamic>;

      if (payload['type'] != expectedType) {
        return null;
      }

      return TokenPayload(
        userId: payload['sub'] as String,
        type: payload['type'] as String,
        issuedAt: DateTime.fromMillisecondsSinceEpoch(
          (payload['iat'] as int) * 1000,
        ),
        expiresAt: DateTime.fromMillisecondsSinceEpoch(
          (payload['exp'] as int) * 1000,
        ),
        additionalClaims: Map<String, dynamic>.from(payload)
          ..remove('sub')
          ..remove('type')
          ..remove('iat')
          ..remove('exp'),
      );
    } on JWTExpiredException {
      return null;
    } on JWTException {
      return null;
    } catch (e) {
      return null;
    }
  }
}

class TokenPair {
  const TokenPair({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  final String accessToken;
  final String refreshToken;
  final int expiresIn; // in seconds

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'expires_in': expiresIn,
        'token_type': 'Bearer',
      };
}

class TokenPayload {
  const TokenPayload({
    required this.userId,
    required this.type,
    required this.issuedAt,
    required this.expiresAt,
    this.additionalClaims = const {},
  });

  final String userId;
  final String type;
  final DateTime issuedAt;
  final DateTime expiresAt;
  final Map<String, dynamic> additionalClaims;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
