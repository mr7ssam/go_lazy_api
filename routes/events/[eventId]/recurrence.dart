import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';

Future<Response> onRequest(RequestContext context, String eventId) async {
  return switch (context.request.method) {
    HttpMethod.get => _getRecurrence(context, eventId),
    HttpMethod.post => _createRecurrence(context, eventId),
    HttpMethod.patch => _updateRecurrence(context, eventId),
    HttpMethod.delete => _deleteRecurrence(context, eventId),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Future<Response> _getRecurrence(
  RequestContext context,
  String eventId,
) async {
  final handler = context.read<GetRecurrenceHandler>();
  final request = GetRecurrenceRequest(eventId: eventId);
  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _createRecurrence(
  RequestContext context,
  String eventId,
) async {
  final handler = context.read<CreateRecurrenceHandler>();
  final json = await context.request.json() as Map<String, dynamic>;
  final request = CreateRecurrenceRequest.fromJson(
    {...json, 'eventId': eventId},
  );
  final result = await handler.handle(request);

  return result.toResponse(statusCode: HttpStatus.created);
}

Future<Response> _updateRecurrence(
  RequestContext context,
  String eventId,
) async {
  final handler = context.read<UpdateRecurrenceHandler>();
  final json = await context.request.json() as Map<String, dynamic>;
  final request = UpdateRecurrenceRequest.fromJson(json, eventId: eventId);
  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _deleteRecurrence(
  RequestContext context,
  String eventId,
) async {
  final handler = context.read<DeleteRecurrenceHandler>();
  final request = DeleteRecurrenceRequest(eventId: eventId);
  final result = await handler.handle(request);

  return result.toResponse();
}
