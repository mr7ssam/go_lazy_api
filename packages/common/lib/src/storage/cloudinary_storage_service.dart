import 'dart:io';

import 'package:cloudinary_api/cloudinary_api.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:common/src/storage/storage_service.dart';

class CloudinaryStorageService implements IStorageService {
  CloudinaryStorageService._({
    required Cloudinary cloudinary,
  }) : _cloudinary = cloudinary;

  factory CloudinaryStorageService.instance() {
    _instance ??= CloudinaryStorageService._(
      cloudinary: Cloudinary.fromStringUrl(
        Platform.environment['CLOUDINARY_URL']!,
      ),
    );

    return _instance!;
  }

  final Cloudinary _cloudinary;

  static CloudinaryStorageService? _instance;

  @override
  Future<String> uploadFile(
    File file, {
    required String folder,
    required String publicId,
  }) async {
    try {
      final response = await _cloudinary.uploader().upload(
            file,
            params: UploadParams(
              folder: folder,
              publicId: publicId,
            ),
          );

      final url = response?.data?.url;

      if (url == null) {
        throw Exception('File upload failed, no URL returned');
      }

      return url;
    } catch (e) {
      throw Exception('Error uploading file to Cloudinary: $e');
    }
  }

  @override
  Future<void> deleteFile(String publicId) async {
    try {
      final response = await _cloudinary.uploader().destroy(
            DestroyParams(
              publicId: publicId,
            ),
          );

      if (response.error != null) {
        throw Exception('File deletion failed: ${response.error?.message}');
      }
    } catch (e) {
      throw Exception('Error deleting file from Cloudinary: $e');
    }
  }

  @override
  String getFileUrl(String publicId) {
    return _cloudinary.image(publicId).toString();
  }
}
