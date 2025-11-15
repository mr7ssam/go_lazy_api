import 'package:dart_frog/dart_frog.dart';
import 'package:user/user_handlers.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405);
  }

  return _createUser(context);
}

Future<Response> _createUser(RequestContext context) async {
  final handler = context.read<CreateUserHandler>();

  final json = await context.request.json() as Map<String, dynamic>;

  final result = await handler.handle(CreateUserRequest.fromJson(json));

  return result.toResponse(statusCode: 201);
}
