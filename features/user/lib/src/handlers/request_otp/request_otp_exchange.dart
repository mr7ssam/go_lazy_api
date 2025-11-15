abstract class RequestOtpRequest {
  const RequestOtpRequest();

  factory RequestOtpRequest.fromJson(Map<String, dynamic> json) {
    if (json['email'] != null) {
      return EmailOtpRequest.fromJson(json);
    } else if (json['phoneNumber'] != null) {
      return PhoneOtpRequest.fromJson(json);
    } else {
      throw Exception('Invalid request: email or phoneNumber is required');
    }
  }

  bool get isEmailRequest => this is EmailOtpRequest;
  bool get isPhoneRequest => this is PhoneOtpRequest;
}

class EmailOtpRequest extends RequestOtpRequest {
  const EmailOtpRequest({
    required this.email,
  });

  factory EmailOtpRequest.fromJson(Map<String, dynamic> json) =>
      EmailOtpRequest(
        email: json['email'] as String,
      );

  final String email;
}

class PhoneOtpRequest extends RequestOtpRequest {
  const PhoneOtpRequest({
    required this.phoneNumber,
  });

  factory PhoneOtpRequest.fromJson(Map<String, dynamic> json) =>
      PhoneOtpRequest(
        phoneNumber: json['phoneNumber'] as String,
      );

  final String phoneNumber;
}

class RequestOtpResponse {
  RequestOtpResponse({
    required this.message,
    required this.expiresAt,
  });

  final String message;
  final DateTime expiresAt;

  Map<String, dynamic> toJson() => {
        'message': message,
        'expiresAt': expiresAt.toIso8601String(),
      };
}
