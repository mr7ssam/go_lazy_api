import 'package:dart_frog/dart_frog.dart';
import 'package:user/user_handlers.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405);
  }

  final handler = context.read<LoginHandler>();

  final body = await context.request.json() as Map<String, dynamic>;
  final request = LoginRequest.fromJson(body);

  return handler.handle(request);
}
