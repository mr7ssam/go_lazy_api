import 'package:dart_frog/dart_frog.dart';
import 'package:group/group_data.dart';
import 'package:group/group_handlers.dart';

Handler middleware(Handler handler) {
  return handler
      .registerGroupDataMiddlewares()
      .use(
        provider<CreateGroupHandler>(
          (context) => CreateGroupHandler(
            groupsRepo: context.read(),
            transactionManager: context.read(),
            localization: context.read(),
          ),
        ),
      )
      .use(
        provider<GetUserGroupsHandler>(
          (context) => GetUserGroupsHandler(
            groupsRepo: context.read(),
            localization: context.read(),
          ),
        ),
      )
      .use(
        provider<GetGroupHandler>(
          (context) => GetGroupHandler(
            groupsRepo: context.read(),
            localization: context.read(),
          ),
        ),
      )
      .use(
        provider<UpdateGroupHandler>(
          (context) => UpdateGroupHandler(
            groupsRepo: context.read(),
            localization: context.read(),
          ),
        ),
      )
      .use(
        provider<DeleteGroupHandler>(
          (context) => DeleteGroupHandler(
            groupsRepo: context.read(),
            localization: context.read(),
          ),
        ),
      )
      .use(
        provider<GetGroupMembersHandler>(
          (context) => GetGroupMembersHandler(
            groupsRepo: context.read(),
            localization: context.read(),
          ),
        ),
      )
      .use(
        provider<AddMemberHandler>(
          (context) => AddMemberHandler(
            groupsRepo: context.read(),
            localization: context.read(),
          ),
        ),
      )
      .use(
        provider<RemoveMemberHandler>(
          (context) => RemoveMemberHandler(
            groupsRepo: context.read(),
            localization: context.read(),
          ),
        ),
      )
      .use(
        provider<UpdateMemberRoleHandler>(
          (context) => UpdateMemberRoleHandler(
            groupsRepo: context.read(),
            localization: context.read(),
          ),
        ),
      );
}
