import 'package:test/test.dart';
import 'package:user/user_domain.dart';

void main() {
  group('User', () {
    group('constructor', () {
      test('creates instance with all required fields', () {
        final user = User(
          id: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phoneNumber: '+1234567890',
          isEmailVerified: true,
          isPhoneVerified: false,
        );

        expect(user.id, '123');
        expect(user.firstName, 'John');
        expect(user.lastName, 'Doe');
        expect(user.email, 'john@example.com');
        expect(user.phoneNumber, '+1234567890');
        expect(user.isEmailVerified, true);
        expect(user.isPhoneVerified, false);
        expect(user.photoUrl, isNull);
      });

      test('creates instance with optional photoUrl', () {
        final user = User(
          id: '123',
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          phoneNumber: '+9876543210',
          isEmailVerified: false,
          isPhoneVerified: true,
          photoUrl: 'https://example.com/photo.jpg',
        );

        expect(user.photoUrl, 'https://example.com/photo.jpg');
      });
    });

    group('create constructor', () {
      test('creates new user with default values', () {
        final user = User.create(
          firstName: 'Alice',
          lastName: 'Johnson',
          email: 'alice@example.com',
          phoneNumber: '+1112223333',
        );

        expect(user.id, isNotEmpty);
        expect(user.firstName, 'Alice');
        expect(user.lastName, 'Johnson');
        expect(user.email, 'alice@example.com');
        expect(user.phoneNumber, '+1112223333');
        expect(user.isEmailVerified, false);
        expect(user.isPhoneVerified, false);
        expect(user.photoUrl, isNull);
      });

      test('creates new user with photoUrl', () {
        final user = User.create(
          firstName: 'Bob',
          lastName: 'Brown',
          email: 'bob@example.com',
          phoneNumber: '+4445556666',
          photoUrl: 'https://example.com/bob.jpg',
        );

        expect(user.photoUrl, 'https://example.com/bob.jpg');
        expect(user.isEmailVerified, false);
        expect(user.isPhoneVerified, false);
      });
    });

    group('copyWith', () {
      late User originalUser;

      setUp(() {
        originalUser = User(
          id: '123',
          firstName: 'Original',
          lastName: 'User',
          email: 'original@example.com',
          phoneNumber: '+1234567890',
          isEmailVerified: false,
          isPhoneVerified: false,
          photoUrl: 'https://example.com/original.jpg',
        );
      });

      test('returns copy with updated id', () {
        final updated = originalUser.copyWith(id: '456');

        expect(updated.id, '456');
        expect(updated.firstName, originalUser.firstName);
        expect(updated.lastName, originalUser.lastName);
      });

      test('returns copy with updated firstName', () {
        final updated = originalUser.copyWith(firstName: 'Updated');

        expect(updated.firstName, 'Updated');
        expect(updated.id, originalUser.id);
      });

      test('returns copy with updated lastName', () {
        final updated = originalUser.copyWith(lastName: 'Changed');

        expect(updated.lastName, 'Changed');
        expect(updated.firstName, originalUser.firstName);
      });

      test('returns copy with updated email', () {
        final updated = originalUser.copyWith(email: 'new@example.com');

        expect(updated.email, 'new@example.com');
        expect(updated.phoneNumber, originalUser.phoneNumber);
      });

      test('returns copy with updated phoneNumber', () {
        final updated = originalUser.copyWith(phoneNumber: '+9999999999');

        expect(updated.phoneNumber, '+9999999999');
        expect(updated.email, originalUser.email);
      });

      test('returns copy with updated isEmailVerified', () {
        final updated = originalUser.copyWith(isEmailVerified: true);

        expect(updated.isEmailVerified, true);
        expect(updated.isPhoneVerified, originalUser.isPhoneVerified);
      });

      test('returns copy with updated isPhoneVerified', () {
        final updated = originalUser.copyWith(isPhoneVerified: true);

        expect(updated.isPhoneVerified, true);
        expect(updated.isEmailVerified, originalUser.isEmailVerified);
      });

      test('returns copy with updated photoUrl', () {
        final updated = originalUser.copyWith(
          photoUrl: 'https://example.com/new.jpg',
        );

        expect(updated.photoUrl, 'https://example.com/new.jpg');
      });

      test('returns copy with multiple updated fields', () {
        final updated = originalUser.copyWith(
          firstName: 'Multi',
          lastName: 'Update',
          isEmailVerified: true,
          isPhoneVerified: true,
        );

        expect(updated.firstName, 'Multi');
        expect(updated.lastName, 'Update');
        expect(updated.isEmailVerified, true);
        expect(updated.isPhoneVerified, true);
        expect(updated.id, originalUser.id);
        expect(updated.email, originalUser.email);
      });

      test('returns copy with no changes when no parameters provided', () {
        final updated = originalUser.copyWith();

        expect(updated.id, originalUser.id);
        expect(updated.firstName, originalUser.firstName);
        expect(updated.lastName, originalUser.lastName);
        expect(updated.email, originalUser.email);
        expect(updated.phoneNumber, originalUser.phoneNumber);
        expect(updated.isEmailVerified, originalUser.isEmailVerified);
        expect(updated.isPhoneVerified, originalUser.isPhoneVerified);
        expect(updated.photoUrl, originalUser.photoUrl);
      });
    });
  });
}
