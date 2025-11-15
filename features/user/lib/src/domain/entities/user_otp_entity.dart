import 'dart:math';

import 'package:uuid/uuid.dart';

enum UserOtpTypeEnum {
  email,
  phone,
  login,
}

const _kOtpExpiryDuration = Duration(minutes: 10);

class UserOtp {
  UserOtp({
    required this.id,
    required this.userId,
    required this.code,
    required this.expiresAt,
    required this.type,
  });

  UserOtp.create({
    required this.userId,
    required this.type,
  })  : id = const Uuid().v4(),
        code = _generateNumericOtp(),
        expiresAt = DateTime.now().toUtc().add(
              _kOtpExpiryDuration,
            );

  final String id;
  final UserOtpTypeEnum type;
  final String userId;
  final String code;
  final DateTime expiresAt;
}

String _generateNumericOtp({int length = 6}) {
  final random = Random.secure();
  final otp = StringBuffer();

  for (var i = 0; i < length; i++) {
    otp.write(random.nextInt(10).toString());
  }

  return otp.toString();
}
