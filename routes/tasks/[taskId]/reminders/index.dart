import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';
import 'package:user/user_data.dart';

Future<Response> onRequest(RequestContext context, String taskId) async {
  return switch (context.request.method) {
    HttpMethod.get => _getTaskReminders(context, taskId),
    HttpMethod.post => _createReminder(context, taskId),
    _ => Response(statusCode: 405),
  };
}

Future<Response> _getTaskReminders(
  RequestContext context,
  String taskId,
) async {
  final handler = context.read<GetTaskRemindersHandler>();
  final userId = context.user!.id;

  final request = GetTaskRemindersRequest(taskId: taskId, userId: userId);

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _createReminder(
  RequestContext context,
  String taskId,
) async {
  final handler = context.read<CreateReminderHandler>();
  final userId = context.user!.id;

  final json = await context.request.json() as Map<String, dynamic>;
  final request = CreateReminderRequest.fromJson(
    {
      ...json,
      'taskId': taskId,
      'userId': userId,
    },
  );

  final result = await handler.handle(request);

  return result.toResponse(statusCode: 201);
}
