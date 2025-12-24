import 'package:dart_frog/dart_frog.dart';
import 'package:group/group_handlers.dart';
import 'package:user/user_domain.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _createGroup(context),
    HttpMethod.get => _getUserGroups(context),
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

Future<Response> _createGroup(RequestContext context) async {
  final handler = context.read<CreateGroupHandler>();
  final user = context.read<User>();

  final json = await context.request.json() as Map<String, dynamic>;
  final request = CreateGroupRequest.fromJson(json).copyWith(userId: user.id);

  final result = await handler.handle(request);

  return result.toResponse(statusCode: 201);
}

Future<Response> _getUserGroups(RequestContext context) async {
  final handler = context.read<GetUserGroupsHandler>();
  final user = context.read<User>();

  final result = await handler.handle(
    GetUserGroupsRequest(userId: user.id),
  );

  return result.toResponse();
}
