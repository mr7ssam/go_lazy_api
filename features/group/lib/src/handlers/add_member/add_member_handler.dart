import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class AddMemberHandler extends IHandler<AddMemberRequest, AddMemberResponse> {
  AddMemberHandler({
    required IGroupsRepo groupsRepo,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<AddMemberResponse>> handle(
    AddMemberRequest request,
  ) async {
    try {
      // Check if requesting user has permission (owner or admin)
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

      final group = await _groupsRepo.getGroupById(request.groupId);
      if (group == null) {
        return HandlerResult.failed(
          error: NotFoundError(
            message: _localization.translations.groupNotFound,
          ),
        );
      }

      // Check if target user is already a member
      final existingMembership = await _groupsRepo.getMembership(
        request.groupId,
        request.targetUserId,
      );
      if (existingMembership != null && existingMembership.isActive) {
        return HandlerResult.failed(
          error: ConflictError(
            message: _localization.translations.groupAlreadyExists,
          ),
        );
      }

      final member = await _groupsRepo.addMember(
        GroupMember.create(
          groupId: request.groupId,
          userId: request.targetUserId,
          role: request.role,
        ),
      );

      return HandlerResult.success(
        data: AddMemberResponse(
          id: member.id,
          groupId: member.groupId,
          userId: member.userId,
          role: member.role,
          joinedAt: member.joinedAt,
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
