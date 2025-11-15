import 'package:dart_frog/dart_frog.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405);
  }

  final user = context.read<User>();

  final handler = context.read<UploadUserPhotoHandler>();

  final formData = await context.request.formData();

  final request = UploadUserPhotoRequest(
    formData: formData,
    user: user,
  );

  final response = await handler.handle(request);

  return Response.json(
    body: response.toJson(),
  );
}
