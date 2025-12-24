import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:location/location_handlers.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => _onGet(context, id),
    HttpMethod.post => _onPost(context, id),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Future<Response> _onGet(RequestContext context, String id) async {
  final handler = context.read<GetLocationsHandler>();

  final queryParams = context.request.uri.queryParameters;
  final request = GetLocationsRequest.fromQueryParams(
    queryParams,
    groupId: id,
  );

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _onPost(RequestContext context, String id) async {
  final handler = context.read<CreateLocationHandler>();

  final json = await context.request.json() as Map<String, dynamic>;
  final request = CreateLocationRequest.fromJson(
    json,
    groupId: id,
  );

  final result = await handler.handle(request);

  return result.toResponse(statusCode: HttpStatus.created);
}
