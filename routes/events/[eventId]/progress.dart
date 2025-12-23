import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';

Future<Response> onRequest(RequestContext context, String eventId) async {
  return switch (context.request.method) {
    HttpMethod.get => _getProgress(context, eventId),
    _ => Future.value(
        Response(statusCode: HttpStatus.methodNotAllowed),
      ),
  };
}

Future<Response> _getProgress(RequestContext context, String eventId) async {
  final handler = context.read<GetEventProgressHandler>();
  final result = await handler.handle(eventId);

  return result.toResponse();
}
