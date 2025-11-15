import 'package:dart_frog/dart_frog.dart';
import 'package:user/user_domain.dart';

class UploadUserPhotoRequest {
  UploadUserPhotoRequest({
    required this.formData,
    required this.user,
  });

  final FormData formData;
  final User user;
}

class UploadUserPhotoResponse {
  UploadUserPhotoResponse({
    required this.photoUrl,
  });

  final String photoUrl;

  Map<String, dynamic> toJson() {
    return {
      'photoUrl': photoUrl,
    };
  }
}
