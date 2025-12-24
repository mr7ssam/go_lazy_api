import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getFeed(context),
    _ => Future.value(
        Response(statusCode: HttpStatus.methodNotAllowed),
      ),
  };
}

Future<Response> _getFeed(RequestContext context) async {
  try {
    final handler = context.read<GetEventFeedHandler>();
    final params = context.request.uri.queryParameters;

    // Parse query parameters
    final startDate = params['startDate'] != null
        ? DateTime.tryParse(params['startDate']!)
        : null;
    final endDate = params['endDate'] != null
        ? DateTime.tryParse(params['endDate']!)
        : null;
    final limit = int.tryParse(params['limit'] ?? '20') ?? 20;
    final offset = int.tryParse(params['offset'] ?? '0') ?? 0;

    final request = GetEventFeedRequest(
      startDate: startDate,
      endDate: endDate,
      limit: limit,
      offset: offset,
    );

    final result = await handler.handle(request);

    return result.toResponse();
  } catch (e) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Invalid request parameters',
    );
  }
}
