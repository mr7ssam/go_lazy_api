import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class DeleteGroupHandler extends IHandler<DeleteGroupRequest, void> {
  DeleteGroupHandler({
    required IGroupsRepo groupsRepo,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<void>> handle(DeleteGroupRequest request) async {
    try {
      // Only owner can delete group
      final isOwner = await _groupsRepo.hasRole(
        request.groupId,
        request.userId,
        [GroupMemberRoleEnum.owner],
      );
      if (!isOwner) {
        return HandlerResult.failed(
          error: ForbiddenError(
            message: _localization.translations.insufficientPermissions,
          ),
        );
      }

      final group = await _groupsRepo.getGroupById(request.groupId);
      if (group == null) {
        return HandlerResult.failed(
          error: NotFoundError(
            message: _localization.translations.groupNotFound,
          ),
        );
      }

      await _groupsRepo.deleteGroup(request.groupId);

      return const HandlerResult.success(data: null);
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(
          message: _localization.translations.internalServerError,
        ),
      );
    }
  }
}
