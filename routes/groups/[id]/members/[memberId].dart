import 'package:dart_frog/dart_frog.dart';
import 'package:group/group_handlers.dart';
import 'package:user/user_domain.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
  String memberId,
) async {
  return switch (context.request.method) {
    HttpMethod.delete => _removeMember(context, id, memberId),
    HttpMethod.put => _updateMemberRole(context, id, memberId),
    _ => Response(statusCode: 405),
  };
}

Future<Response> _removeMember(
  RequestContext context,
  String groupId,
  String targetUserId,
) async {
  final handler = context.read<RemoveMemberHandler>();
  final user = context.read<User>();

  final result = await handler.handle(
    RemoveMemberRequest(
      groupId: groupId,
      requestingUserId: user.id,
      targetUserId: targetUserId,
    ),
  );

  return result.toResponse(statusCode: 204);
}

Future<Response> _updateMemberRole(
  RequestContext context,
  String groupId,
  String targetUserId,
) async {
  final handler = context.read<UpdateMemberRoleHandler>();
  final user = context.read<User>();

  final json = await context.request.json() as Map<String, dynamic>;
  final request = UpdateMemberRoleRequest.fromJson({
    ...json,
    'groupId': groupId,
    'requestingUserId': user.id,
    'targetUserId': targetUserId,
  });

  final result = await handler.handle(request);

  return result.toResponse();
}
