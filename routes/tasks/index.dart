import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';
import 'package:user/user_data.dart';

Future<Response> onRequest(RequestContext context, String taskId) async {
  return switch (context.request.method) {
    HttpMethod.get => _getTask(context, taskId),
    HttpMethod.patch => _updateTask(context, taskId),
    HttpMethod.delete => _deleteTask(context, taskId),
    _ => Response(statusCode: 405),
  };
}

Future<Response> _getTask(RequestContext context, String taskId) async {
  final handler = context.read<GetTaskHandler>();
  final userId = context.user!.id;

  final request = GetTaskRequest(taskId: taskId, userId: userId);

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _updateTask(RequestContext context, String taskId) async {
  final handler = context.read<UpdateTaskHandler>();
  final userId = context.user!.id;

  final json = await context.request.json() as Map<String, dynamic>;
  final request = UpdateTaskRequest.fromJson(json).copyWith(
    taskId: taskId,
    userId: userId,
  );

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _deleteTask(RequestContext context, String taskId) async {
  final handler = context.read<DeleteTaskHandler>();
  final userId = context.user?.id ?? '';

  final request = DeleteTaskRequest(taskId: taskId, userId: userId);

  final result = await handler.handle(request);

  return result.toResponse(statusCode: 204);
}
