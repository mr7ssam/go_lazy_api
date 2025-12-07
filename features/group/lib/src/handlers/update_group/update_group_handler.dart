import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class UpdateGroupHandler
    extends IHandler<UpdateGroupRequest, UpdateGroupResponse> {
  UpdateGroupHandler({
    required IGroupsRepo groupsRepo,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<UpdateGroupResponse>> handle(
    UpdateGroupRequest request,
  ) async {
    try {
      // Check if user has permission (owner or admin)
      final hasPermission = await _groupsRepo.hasRole(
        request.groupId,
        request.userId,
        [GroupMemberRoleEnum.owner, GroupMemberRoleEnum.admin],
      );
      if (!hasPermission) {
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

      final updatedGroup = group.copyWith(
        name: request.name,
        description: request.description,
        imageUrl: request.imageUrl,
        updatedAt: DateTime.now().toUtc(),
      );

      await _groupsRepo.updateGroup(updatedGroup);

      return HandlerResult.success(
        data: UpdateGroupResponse(
          id: updatedGroup.id,
          name: updatedGroup.name,
          description: updatedGroup.description,
          imageUrl: updatedGroup.imageUrl,
          createdBy: updatedGroup.createdBy,
          createdAt: updatedGroup.createdAt,
          updatedAt: updatedGroup.updatedAt,
        ),
      );
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(
          message: _localization.translations.internalServerError,
        ),
      );
    }
  }
}
