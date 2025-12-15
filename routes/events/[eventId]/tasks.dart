import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';
import 'package:user/user_data.dart';

Future<Response> onRequest(RequestContext context, String eventId) async {
  return switch (context.request.method) {
    HttpMethod.get => _getEventTasks(context, eventId),
    HttpMethod.post => _createTask(context, eventId),
    _ => Response(statusCode: 405),
  };
}

Future<Response> _getEventTasks(
  RequestContext context,
  String eventId,
) async {
  final handler = context.read<GetEventTasksHandler>();
  final userId = context.user!.id;

  final request = GetEventTasksRequest(eventId: eventId, userId: userId);

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _createTask(RequestContext context, String eventId) async {
  final handler = context.read<CreateTaskHandler>();
  final userId = context.user!.id;

  final json = await context.request.json() as Map<String, dynamic>;
  final request = CreateTaskRequest.fromJson(
    {
      ...json,
      'createdBy': userId,
      'eventId': eventId,
    },
  );

  final result = await handler.handle(request);

  return result.toResponse(statusCode: 201);
}
