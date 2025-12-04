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
      );
}
