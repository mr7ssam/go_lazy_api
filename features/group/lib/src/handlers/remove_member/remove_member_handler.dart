import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class RemoveMemberHandler extends IHandler<RemoveMemberRequest, void> {
  RemoveMemberHandler({
    required IGroupsRepo groupsRepo,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<void>> handle(RemoveMemberRequest request) async {
    try {
      final group = await _groupsRepo.getGroupById(request.groupId);
      if (group == null) {
        return HandlerResult.failed(
          error: NotFoundError(
            message: _localization.translations.groupNotFound,
          ),
        );
      }

      // Get membership of target user
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

      // Cannot remove the owner
      if (targetMembership.role == GroupMemberRoleEnum.owner) {
        return HandlerResult.failed(
          error: ForbiddenError(
            message: _localization.translations.cannotRemoveOwner,
          ),
        );
      }

      // User can remove themselves, or owner/admin can remove others
      final isSelfRemoval = request.requestingUserId == request.targetUserId;
      if (!isSelfRemoval) {
        final hasPermission = await _groupsRepo.hasRole(
          request.groupId,
          request.requestingUserId,
          [GroupMemberRoleEnum.owner, GroupMemberRoleEnum.admin],
        );
        if (!hasPermission) {
          return HandlerResult.failed(
            error: ForbiddenError(
              message: _localization.translations.insufficientPermissions,
            ),
          );
        }
      }

      await _groupsRepo.removeMember(targetMembership.id);

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
