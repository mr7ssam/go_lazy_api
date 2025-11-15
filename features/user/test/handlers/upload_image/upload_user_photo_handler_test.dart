import 'dart:io';

import 'package:common/common.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class _MockStorageService extends Mock implements IStorageService {}

class _MockUsersRepo extends Mock implements IUsersRepo {}

void main() {
  late _MockStorageService storageService;
  late _MockUsersRepo usersRepo;
  late UploadUserPhotoHandler handler;
  late User user;

  setUpAll(() {
    registerFallbackValue(
      User(
        id: 'user-id',
        firstName: 'first',
        lastName: 'last',
        email: 'user@example.com',
        phoneNumber: '+10000000000',
        isEmailVerified: true,
        isPhoneVerified: true,
      ),
    );
    registerFallbackValue(File('dummy.txt'));
  });

  setUp(() {
    storageService = _MockStorageService();
    usersRepo = _MockUsersRepo();
    handler = UploadUserPhotoHandler(
      storageService: storageService,
      usersRepo: usersRepo,
    );
    user = User(
      id: 'user-123',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@example.com',
      phoneNumber: '+1234567890',
      isEmailVerified: true,
      isPhoneVerified: true,
    );
  });

  group('UploadUserPhotoHandler', () {
    test('uploads file and updates user photo URL', () async {
      final fileBytes = List<int>.from([1, 2, 3, 4]);
      final uploadedFile = UploadedFile(
        'avatar.png',
        ContentType('image', 'png'),
        Stream.fromIterable([fileBytes]),
      );
      final formData =
          FormData(fields: const {}, files: {'avatar': uploadedFile});
      when(
        () => storageService.uploadFile(
          any(),
          folder: 'users/${user.id}/profile',
          publicId: any(named: 'publicId'),
        ),
      ).thenAnswer((invocation) async {
        final uploadedFile = invocation.positionalArguments.first as File;
        expect(uploadedFile.existsSync(), isTrue);
        return 'https://example.com/avatar.png';
      });
      when(() => usersRepo.save(any())).thenAnswer((_) async {});

      final result = await handler.handle(
        UploadUserPhotoRequest(formData: formData, user: user),
      );

      expect(result, isA<HandlerResult<UploadUserPhotoResponse>>());
      result.when(
        success: (response) {
          expect(response.photoUrl, equals('https://example.com/avatar.png'));
          verify(
            () => usersRepo.save(
              any(
                that: predicate<User>(
                  (updated) =>
                      updated.id == user.id &&
                      updated.photoUrl == response.photoUrl,
                ),
              ),
            ),
          ).called(1);
        },
        failed: (error) => fail('Expected success but got error: $error'),
      );

      final verification = verify(
        () => storageService.uploadFile(
          any(),
          folder: captureAny(named: 'folder'),
          publicId: captureAny(named: 'publicId'),
        ),
      );
      final captured = verification.captured;
      final folder = captured[0] as String;
      final publicId = captured[1] as String;
      expect(folder, equals('users/${user.id}/profile'));
      expect(publicId, startsWith('avatar_'));
    });

    test('returns InternalServerError when no file is provided', () async {
      const formData = FormData(fields: {}, files: {});

      final result = await handler.handle(
        UploadUserPhotoRequest(formData: formData, user: user),
      );

      expect(result, isA<HandlerResult<UploadUserPhotoResponse>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<InternalServerError>());
          expect(error.message, contains('No file provided'));
        },
      );
      verifyNever(
        () => storageService.uploadFile(
          any(),
          folder: any(named: 'folder'),
          publicId: any(named: 'publicId'),
        ),
      );
    });

    test('returns InternalServerError when storage upload fails', () async {
      final uploadedFile = UploadedFile(
        'avatar.png',
        ContentType('image', 'png'),
        Stream.fromIterable(<List<int>>[
          [1, 2, 3],
        ]),
      );
      final formData =
          FormData(fields: const {}, files: {'avatar': uploadedFile});
      when(
        () => storageService.uploadFile(
          any(),
          folder: any(named: 'folder'),
          publicId: any(named: 'publicId'),
        ),
      ).thenThrow(Exception('upload failed'));

      final result = await handler.handle(
        UploadUserPhotoRequest(formData: formData, user: user),
      );

      expect(result, isA<HandlerResult<UploadUserPhotoResponse>>());
      result.when(
        success: (_) => fail('Expected error but got success'),
        failed: (error) {
          expect(error, isA<InternalServerError>());
          expect(error.message, contains('Failed to upload image'));
          expect(error.message, contains('upload failed'));
        },
      );
      verifyNever(() => usersRepo.save(any()));
    });
  });
}
