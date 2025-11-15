import 'package:dart_frog/dart_frog.dart';
import 'package:user/user_data.dart';
import 'package:user/user_handlers.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.get) {
    final user = context.user;

    final handler = context.read<GetUserHandler>();

    return handler.handle(user);
  }

  return Response(statusCode: 405);
}
