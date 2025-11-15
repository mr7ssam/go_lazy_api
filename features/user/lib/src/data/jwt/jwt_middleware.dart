import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:user/user_domain.dart';

const _notAppliedTo = [
  'user/login',
  'user/refresh_token',
  'user/create',
  'user/otp',
];

Middleware jwtAuthMiddleware() {
  return bearerAuthentication<User>(
    authenticator: (context, token) {
      final userRepository = context.read<IUsersRepo>();

      return userRepository.fromToken(token);
    },
    applies: (RequestContext context) async {
      return !_notAppliedTo.contains(context.request.url.path);
    },
  );
}

extension AuthContext on RequestContext {
  User? get user => read<User>();
}
