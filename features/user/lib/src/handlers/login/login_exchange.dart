abstract class LoginRequest {
  const LoginRequest({
    required this.otp,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    if (json['email'] != null) {
      return EmailLoginRequest.fromJson(json);
    } else if (json['phoneNumber'] != null) {
      return PhoneLoginRequest.fromJson(json);
    } else {
      throw Exception('Invalid login request');
    }
  }

  final String otp;

  bool get isEmailLogin => this is EmailLoginRequest;
  bool get isPhoneLogin => this is PhoneLoginRequest;
}

class EmailLoginRequest extends LoginRequest {
  const EmailLoginRequest({
    required this.email,
    required super.otp,
  });

  factory EmailLoginRequest.fromJson(Map<String, dynamic> json) =>
      EmailLoginRequest(
        email: json['email'] as String,
        otp: json['otp'] as String,
      );

  final String email;
}

class PhoneLoginRequest extends LoginRequest {
  const PhoneLoginRequest({
    required this.phoneNumber,
    required super.otp,
  });

  factory PhoneLoginRequest.fromJson(Map<String, dynamic> json) =>
      PhoneLoginRequest(
        phoneNumber: json['phoneNumber'] as String,
        otp: json['otp'] as String,
      );

  final String phoneNumber;
}

class LoginResponse {
  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
      );

  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
