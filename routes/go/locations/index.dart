import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:location/location_handlers.dart';
import 'package:user/user_domain.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _onGet(context),
    HttpMethod.post => _onPost(context),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Future<Response> _onGet(RequestContext context) async {
  final user = context.read<User>();
  final handler = context.read<GetLocationsHandler>();

  final queryParams = context.request.uri.queryParameters;
  final request = GetLocationsRequest.fromQueryParams(
    queryParams,
    userId: user.id,
  );

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _onPost(RequestContext context) async {
  final user = context.read<User>();
  final handler = context.read<CreateLocationHandler>();

  final json = await context.request.json() as Map<String, dynamic>;
  final request = CreateLocationRequest.fromJson(
    json,
    userId: user.id,
  );

  final result = await handler.handle(request);

  return result.toResponse(statusCode: HttpStatus.created);
}
