class GetUserResponse {
  GetUserResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final bool isEmailVerified;
  final bool isPhoneVerified;

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'isEmailVerified': isEmailVerified,
        'isPhoneVerified': isPhoneVerified,
      };
}
