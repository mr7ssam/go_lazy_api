import 'package:dart_frog/dart_frog.dart';
import 'package:go/go_handlers.dart';
import 'package:user/user_data.dart';

Future<Response> onRequest(
  RequestContext context,
  String taskId,
  String reminderId,
) async {
  return switch (context.request.method) {
    HttpMethod.patch => _updateReminder(context, reminderId),
    HttpMethod.delete => _deleteReminder(context, reminderId),
    _ => Response(statusCode: 405),
  };
}

Future<Response> _updateReminder(
  RequestContext context,
  String reminderId,
) async {
  final handler = context.read<UpdateReminderHandler>();
  final userId = context.user!.id;

  final json = await context.request.json() as Map<String, dynamic>;
  final request = UpdateReminderRequest.fromJson(
    {
      ...json,
      'id': reminderId,
      'userId': userId,
    },
  );

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _deleteReminder(
  RequestContext context,
  String reminderId,
) async {
  final handler = context.read<DeleteReminderHandler>();
  final userId = context.user!.id;

  final request = DeleteReminderRequest(id: reminderId, userId: userId);

  final result = await handler.handle(request);

  return result.toResponse();
}
