import 'package:dart_frog/dart_frog.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

void main() {
  group('UploadUserPhotoRequest', () {
    test('creates instance with required fields', () {
      const formData = FormData(fields: {}, files: {});
      final user = User(
        id: 'user-123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        isEmailVerified: true,
        isPhoneVerified: false,
      );

      final request = UploadUserPhotoRequest(
        formData: formData,
        user: user,
      );

      expect(request.formData, formData);
      expect(request.user, user);
      expect(request.user.id, 'user-123');
    });

    test('stores user reference correctly', () {
      const formData = FormData(fields: {}, files: {});
      final user = User(
        id: 'user-456',
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        phoneNumber: '+9876543210',
        isEmailVerified: false,
        isPhoneVerified: true,
      );

      final request = UploadUserPhotoRequest(
        formData: formData,
        user: user,
      );

      expect(request.user.firstName, 'Jane');
      expect(request.user.email, 'jane@example.com');
    });
  });

  group('UploadUserPhotoResponse', () {
    group('constructor', () {
      test('creates instance with required fields', () {
        final response = UploadUserPhotoResponse(
          photoUrl: 'https://example.com/photo.jpg',
        );

        expect(response.photoUrl, 'https://example.com/photo.jpg');
      });

      test('supports different photo URLs', () {
        final response = UploadUserPhotoResponse(
          photoUrl: 'https://cdn.cloudinary.com/user/abc123.png',
        );

        expect(response.photoUrl, 'https://cdn.cloudinary.com/user/abc123.png');
      });
    });

    group('toJson', () {
      test('converts instance to JSON', () {
        final response = UploadUserPhotoResponse(
          photoUrl: 'https://example.com/avatar.jpg',
        );

        final json = response.toJson();

        expect(json, {
          'photoUrl': 'https://example.com/avatar.jpg',
        });
      });

      test('JSON contains photoUrl key', () {
        final response = UploadUserPhotoResponse(
          photoUrl: 'https://storage.example.com/img.png',
        );

        final json = response.toJson();

        expect(json.containsKey('photoUrl'), isTrue);
        expect(json.keys.length, 1);
      });

      test('photoUrl value matches constructor input', () {
        const url = 'https://example.com/profile/user123.jpg';
        final response = UploadUserPhotoResponse(photoUrl: url);

        final json = response.toJson();

        expect(json['photoUrl'], url);
      });
    });
  });
}
