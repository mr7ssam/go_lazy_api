import 'package:test/test.dart';
import 'package:user/user_handlers.dart';

void main() {
  group('CreateUserRequest', () {
    group('fromJson', () {
      test('creates instance from valid JSON with all fields', () {
        final json = {
          'email': 'test@example.com',
          'phoneNumber': '+1234567890',
          'firstName': 'John',
          'lastName': 'Doe',
          'photoUrl': 'https://example.com/photo.jpg',
        };

        final request = CreateUserRequest.fromJson(json);

        expect(request.email, 'test@example.com');
        expect(request.phoneNumber, '+1234567890');
        expect(request.firstName, 'John');
        expect(request.lastName, 'Doe');
        expect(request.photoUrl, 'https://example.com/photo.jpg');
      });

      test('creates instance from JSON without photoUrl', () {
        final json = {
          'email': 'test@example.com',
          'phoneNumber': '+1234567890',
          'firstName': 'Jane',
          'lastName': 'Smith',
        };

        final request = CreateUserRequest.fromJson(json);

        expect(request.email, 'test@example.com');
        expect(request.phoneNumber, '+1234567890');
        expect(request.firstName, 'Jane');
        expect(request.lastName, 'Smith');
        expect(request.photoUrl, isNull);
      });

      test('handles photoUrl as null explicitly', () {
        final json = {
          'email': 'test@example.com',
          'phoneNumber': '+1234567890',
          'firstName': 'Bob',
          'lastName': 'Brown',
          'photoUrl': null,
        };

        final request = CreateUserRequest.fromJson(json);

        expect(request.photoUrl, isNull);
      });
    });

    group('constructor', () {
      test('creates instance with all required fields', () {
        const request = CreateUserRequest(
          email: 'test@example.com',
          phoneNumber: '+9876543210',
          firstName: 'Alice',
          lastName: 'Johnson',
        );

        expect(request.email, 'test@example.com');
        expect(request.phoneNumber, '+9876543210');
        expect(request.firstName, 'Alice');
        expect(request.lastName, 'Johnson');
        expect(request.photoUrl, isNull);
      });

      test('creates instance with optional photoUrl', () {
        const request = CreateUserRequest(
          email: 'test@example.com',
          phoneNumber: '+1112223333',
          firstName: 'Charlie',
          lastName: 'Davis',
          photoUrl: 'https://example.com/charlie.jpg',
        );

        expect(request.photoUrl, 'https://example.com/charlie.jpg');
      });
    });
  });
}
