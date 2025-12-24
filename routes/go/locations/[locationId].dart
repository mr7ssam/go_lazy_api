import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:location/location_handlers.dart';
import 'package:user/user_domain.dart';

Future<Response> onRequest(RequestContext context, String locationId) async {
  return switch (context.request.method) {
    HttpMethod.patch => _onPatch(context, locationId),
    HttpMethod.delete => _onDelete(context, locationId),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Future<Response> _onPatch(RequestContext context, String locationId) async {
  final user = context.read<User>();
  final handler = context.read<UpdateLocationHandler>();

  final locId = int.tryParse(locationId);
  if (locId == null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Invalid location ID',
    );
  }

  final json = await context.request.json() as Map<String, dynamic>;
  final request = UpdateLocationRequest.fromJson(
    json,
    locationId: locId,
    userId: user.id,
  );

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _onDelete(RequestContext context, String locationId) async {
  final user = context.read<User>();
  final handler = context.read<DeleteLocationHandler>();

  final locId = int.tryParse(locationId);
  if (locId == null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Invalid location ID',
    );
  }

  final request = DeleteLocationRequest(
    locationId: locId,
    userId: user.id,
  );
  final result = await handler.handle(request);

  return result.toResponse();
}
