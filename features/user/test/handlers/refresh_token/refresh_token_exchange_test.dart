import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

void main() {
  group('RefreshTokenRequest', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        const request = RefreshTokenRequest(
          refreshToken: 'refresh-token-123',
        );

        expect(request.refreshToken, 'refresh-token-123');
      });
    });

    group('fromJson', () {
      test('creates instance from valid JSON', () {
        final json = {
          'refresh_token': 'test-refresh-token',
        };

        final request = RefreshTokenRequest.fromJson(json);

        expect(request.refreshToken, 'test-refresh-token');
      });

      test('uses snake_case key for JSON parsing', () {
        final json = {
          'refresh_token': 'my-token-value',
        };

        final request = RefreshTokenRequest.fromJson(json);

        expect(request.refreshToken, 'my-token-value');
      });
    });
  });

  group('RefreshTokenResponse', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        final response = RefreshTokenResponse(
          accessToken: 'new-access-token',
          refreshToken: 'new-refresh-token',
        );

        expect(response.accessToken, 'new-access-token');
        expect(response.refreshToken, 'new-refresh-token');
      });
    });

    group('toJson', () {
      test('converts instance to JSON', () {
        final response = RefreshTokenResponse(
          accessToken: 'test-access-token',
          refreshToken: 'test-refresh-token',
        );

        final json = response.toJson();

        expect(json, {
          'accessToken': 'test-access-token',
          'refreshToken': 'test-refresh-token',
        });
      });

      test('uses camelCase keys in JSON output', () {
        final response = RefreshTokenResponse(
          accessToken: 'my-access',
          refreshToken: 'my-refresh',
        );

        final json = response.toJson();

        expect(json.containsKey('accessToken'), isTrue);
        expect(json.containsKey('refreshToken'), isTrue);
        expect(json.containsKey('access_token'), isFalse);
        expect(json.containsKey('refresh_token'), isFalse);
      });

      test('JSON contains all expected keys', () {
        final response = RefreshTokenResponse(
          accessToken: 'token-1',
          refreshToken: 'token-2',
        );

        final json = response.toJson();

        expect(json.keys, containsAll(['accessToken', 'refreshToken']));
        expect(json.keys.length, 2);
      });
    });
  });
}
