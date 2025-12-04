import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:group/src/data/repo/index.dart';

export 'repo/index.dart';
export 'transformers/index.dart';

extension GroupDataMiddlewares on Handler {
  Handler registerGroupDataMiddlewares() {
    return use(
      provider<IGroupsRepo>(
        (context) => GroupsRepo(
          groupsDao: context.read<GroupsDao>(),
          usersDao: context.read<UsersDao>(),
        ),
      ),
    );
  }
}
