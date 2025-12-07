import 'package:dart_frog/dart_frog.dart';
import 'package:group/group_handlers.dart';
import 'package:user/user_domain.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => _getMembers(context, id),
    HttpMethod.post => _addMember(context, id),
    _ => Response(statusCode: 405),
  };
}

Future<Response> _getMembers(RequestContext context, String groupId) async {
  final handler = context.read<GetGroupMembersHandler>();
  final user = context.read<User>();

  final result = await handler.handle(
    GetGroupMembersRequest(groupId: groupId, userId: user.id),
  );

  return result.toResponse();
}

Future<Response> _addMember(RequestContext context, String groupId) async {
  final handler = context.read<AddMemberHandler>();
  final user = context.read<User>();

  final json = await context.request.json() as Map<String, dynamic>;
  final request = AddMemberRequest.fromJson({
    ...json,
    'groupId': groupId,
    'requestingUserId': user.id,
  });

  final result = await handler.handle(request);

  return result.toResponse(statusCode: 201);
}
