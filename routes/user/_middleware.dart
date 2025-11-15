import 'package:dart_frog/dart_frog.dart';
import 'package:user/user_handlers.dart';

Handler middleware(Handler handler) {
  return handler.registerUserHandlersMiddlewares();
}
