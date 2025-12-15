import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';

Handler middleware(Handler handler) {
  return handler.registerGoHandlersMiddlewares();
}
