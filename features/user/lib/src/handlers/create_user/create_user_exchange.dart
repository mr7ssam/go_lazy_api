class CreateUserRequest {
  const CreateUserRequest({
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    this.photoUrl,
  });

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      CreateUserRequest(
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        photoUrl: json['photoUrl'] as String?,
      );

  final String email;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String? photoUrl;
}
