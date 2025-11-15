import 'dart:io';

import 'package:common/common.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class UploadUserPhotoHandler
    extends IHandler<UploadUserPhotoRequest, UploadUserPhotoResponse> {
  UploadUserPhotoHandler({
    required IStorageService storageService,
    required IUsersRepo usersRepo,
  })  : _storageService = storageService,
        _usersRepo = usersRepo;

  final IStorageService _storageService;
  final IUsersRepo _usersRepo;

  @override
  Future<HandlerResult<UploadUserPhotoResponse>> handle(
    UploadUserPhotoRequest request,
  ) async {
    try {
      final files = request.formData.files;

      if (files.isEmpty) {
        throw Exception('No file provided in the request');
      }

      final uploadedFile = files.values.first;

      final bytes = await uploadedFile.readAsBytes();
      final fileName = uploadedFile.name;

      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsBytes(bytes);

      try {
        final photoUrl = await _storageService.uploadFile(
          tempFile,
          folder: 'users/${request.user.id}/profile',
          publicId: 'avatar_${DateTime.now().millisecondsSinceEpoch}',
        );

        await _usersRepo.save(
          request.user.copyWith(photoUrl: photoUrl),
        );

        return HandlerResult.success(
          data: UploadUserPhotoResponse(photoUrl: photoUrl),
        );
      } finally {
        if (tempFile.existsSync()) {
          await tempFile.delete();
        }
      }
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(
          message: 'Failed to upload image: $e',
        ),
      );
    }
  }
}
