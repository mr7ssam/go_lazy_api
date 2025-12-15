import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';
import 'package:user/user_data.dart';

Future<Response> onRequest(RequestContext context, String taskId) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405);
  }

  return _markTaskDone(context, taskId);
}

Future<Response> _markTaskDone(RequestContext context, String taskId) async {
  final handler = context.read<MarkTaskDoneHandler>();
  final userId = context.user!.id;

  final json = await context.request.json() as Map<String, dynamic>? ?? {};
  final isDone = json['isDone'] as bool? ?? true;

  final request = MarkTaskDoneRequest(
    taskId: taskId,
    userId: userId,
    isDone: isDone,
  );

  final result = await handler.handle(request);

  return result.toResponse();
}
