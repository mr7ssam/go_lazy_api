import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class UpdateMemberRoleHandler
    extends IHandler<UpdateMemberRoleRequest, UpdateMemberRoleResponse> {
  UpdateMemberRoleHandler({
    required IGroupsRepo groupsRepo,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<UpdateMemberRoleResponse>> handle(
    UpdateMemberRoleRequest request,
  ) async {
    try {
      // Only owner can change roles
      final isOwner = await _groupsRepo.hasRole(
        request.groupId,
        request.requestingUserId,
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

      // Get target membership
      final targetMembership = await _groupsRepo.getMembership(
        request.groupId,
        request.targetUserId,
      );
      if (targetMembership == null || !targetMembership.isActive) {
        return HandlerResult.failed(
          error: NotFoundError(
            message: _localization.translations.notGroupMember,
          ),
        );
      }

      // Cannot change owner's role
      if (targetMembership.role == GroupMemberRoleEnum.owner) {
        return HandlerResult.failed(
          error: ForbiddenError(
            message: _localization.translations.cannotRemoveOwner,
          ),
        );
      }

      // Cannot assign owner role to another member
      if (request.newRole == GroupMemberRoleEnum.owner) {
        return HandlerResult.failed(
          error: ForbiddenError(
            message: _localization.translations.insufficientPermissions,
          ),
        );
      }

      await _groupsRepo.updateMemberRole(targetMembership.id, request.newRole);

      return HandlerResult.success(
        data: UpdateMemberRoleResponse(
          id: targetMembership.id,
          groupId: targetMembership.groupId,
          userId: targetMembership.userId,
          role: request.newRole,
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
