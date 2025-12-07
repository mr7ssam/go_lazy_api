import 'package:dart_frog/dart_frog.dart';
import 'package:group/group_handlers.dart';
import 'package:user/user_domain.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => _getGroup(context, id),
    HttpMethod.put => _updateGroup(context, id),
    HttpMethod.delete => _deleteGroup(context, id),
    _ => Response(statusCode: 405),
  };
}

Future<Response> _getGroup(RequestContext context, String groupId) async {
  final handler = context.read<GetGroupHandler>();
  final user = context.read<User>();

  final result = await handler.handle(
    GetGroupRequest(groupId: groupId, userId: user.id),
  );

  return result.toResponse();
}

Future<Response> _updateGroup(RequestContext context, String groupId) async {
  final handler = context.read<UpdateGroupHandler>();
  final user = context.read<User>();

  final json = await context.request.json() as Map<String, dynamic>;
  final request = UpdateGroupRequest.fromJson({
    ...json,
    'groupId': groupId,
    'userId': user.id,
  });

  final result = await handler.handle(request);

  return result.toResponse();
}

Future<Response> _deleteGroup(RequestContext context, String groupId) async {
  final handler = context.read<DeleteGroupHandler>();
  final user = context.read<User>();

  final result = await handler.handle(
    DeleteGroupRequest(groupId: groupId, userId: user.id),
  );

  return result.toResponse(statusCode: 204);
}
