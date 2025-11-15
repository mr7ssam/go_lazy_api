import 'package:common/common.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

void main() {
  late LocalizationService localization;
  late GetUserHandler handler;

  setUp(() {
    localization = LocalizationService();
    handler = GetUserHandler(localization: localization);
  });

  group('GetUserHandler', () {
    test('returns NotFoundError when user is null', () async {
      final result = await handler.handle(null);

      expect(result, isA<HandlerResult<GetUserResponse>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.statusCode, equals(404));
          expect(error.message, equals(localization.translations.userNotFound));
        },
      );
    });

    test('returns user details when user exists', () async {
      final user = User(
        id: 'user-1',
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@example.com',
        phoneNumber: '+1234567890',
        isEmailVerified: true,
        isPhoneVerified: false,
      );

      final result = await handler.handle(user);

      expect(result, isA<HandlerResult<GetUserResponse>>());
      result.when(
        success: (response) {
          expect(response.id, equals(user.id));
          expect(response.firstName, equals(user.firstName));
          expect(response.lastName, equals(user.lastName));
          expect(response.email, equals(user.email));
          expect(response.phoneNumber, equals(user.phoneNumber));
          expect(response.isEmailVerified, equals(true));
          expect(response.isPhoneVerified, equals(false));
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );
    });
  });
}
