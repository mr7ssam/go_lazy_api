import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

void main() {
  group('GetUserResponse', () {
    group('constructor', () {
      test('creates instance with all required fields', () {
        final response = GetUserResponse(
          id: 'user-123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phoneNumber: '+1234567890',
          isEmailVerified: true,
          isPhoneVerified: false,
        );

        expect(response.id, 'user-123');
        expect(response.firstName, 'John');
        expect(response.lastName, 'Doe');
        expect(response.email, 'john@example.com');
        expect(response.phoneNumber, '+1234567890');
        expect(response.isEmailVerified, true);
        expect(response.isPhoneVerified, false);
      });

      test('creates instance with verified email and phone', () {
        final response = GetUserResponse(
          id: 'user-456',
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          phoneNumber: '+9876543210',
          isEmailVerified: true,
          isPhoneVerified: true,
        );

        expect(response.isEmailVerified, true);
        expect(response.isPhoneVerified, true);
      });

      test('creates instance with unverified email and phone', () {
        final response = GetUserResponse(
          id: 'user-789',
          firstName: 'Bob',
          lastName: 'Brown',
          email: 'bob@example.com',
          phoneNumber: '+1112223333',
          isEmailVerified: false,
          isPhoneVerified: false,
        );

        expect(response.isEmailVerified, false);
        expect(response.isPhoneVerified, false);
      });
    });

    group('toJson', () {
      test('converts instance to JSON with all fields', () {
        final response = GetUserResponse(
          id: 'user-abc',
          firstName: 'Alice',
          lastName: 'Johnson',
          email: 'alice@example.com',
          phoneNumber: '+4445556666',
          isEmailVerified: true,
          isPhoneVerified: false,
        );

        final json = response.toJson();

        expect(json, {
          'id': 'user-abc',
          'firstName': 'Alice',
          'lastName': 'Johnson',
          'email': 'alice@example.com',
          'phoneNumber': '+4445556666',
          'isEmailVerified': true,
          'isPhoneVerified': false,
        });
      });

      test('converts instance with verified flags to JSON', () {
        final response = GetUserResponse(
          id: 'user-xyz',
          firstName: 'Charlie',
          lastName: 'Davis',
          email: 'charlie@example.com',
          phoneNumber: '+7778889999',
          isEmailVerified: true,
          isPhoneVerified: true,
        );

        final json = response.toJson();

        expect(json['isEmailVerified'], true);
        expect(json['isPhoneVerified'], true);
      });

      test('JSON contains all expected keys', () {
        final response = GetUserResponse(
          id: 'test-id',
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          phoneNumber: '+1234567890',
          isEmailVerified: false,
          isPhoneVerified: false,
        );

        final json = response.toJson();

        expect(
          json.keys,
          containsAll([
            'id',
            'firstName',
            'lastName',
            'email',
            'phoneNumber',
            'isEmailVerified',
            'isPhoneVerified',
          ]),
        );
        expect(json.keys.length, 7);
      });
    });
  });
}
