import 'dart:io';

/// Abstract interface for storage services.
/// Implementations can use different cloud storage providers
/// (e.g., Cloudinary, AWS S3, Google Cloud Storage).
abstract class IStorageService {
  /// Uploads a file to the storage service.
  ///
  /// [file] - The file to upload
  /// [folder] - Optional folder/path in the storage service
  /// [publicId] - Optional custom public ID for the uploaded file
  ///
  /// Returns the public URL of the uploaded file.
  Future<String> uploadFile(
    File file, {
    required String folder,
    required String publicId,
  });

  /// Deletes a file from the storage service.
  ///
  /// [publicId] - The public ID of the file to delete
  ///
  /// Returns true if the deletion was successful.
  Future<void> deleteFile(String publicId);

  /// Gets the public URL of a file stored in the storage service.
  ///
  /// [publicId] - The public ID of the file
  /// Returns the public URL of the file.
  String getFileUrl(String publicId);
}
