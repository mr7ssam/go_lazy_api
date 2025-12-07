import 'package:common/common.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class GetGroupHandler extends IHandler<GetGroupRequest, GetGroupResponse> {
  GetGroupHandler({
    required IGroupsRepo groupsRepo,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<GetGroupResponse>> handle(
    GetGroupRequest request,
  ) async {
    try {
      // Check if user is a member of the group
      final isMember = await _groupsRepo.isGroupMember(
        request.groupId,
        request.userId,
      );
      if (!isMember) {
        return HandlerResult.failed(
          error: ForbiddenError(
            message: _localization.translations.notGroupMember,
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

      final members = await _groupsRepo.getGroupMembers(request.groupId);
      final memberCount = members.where((m) => m.member.isActive).length;

      return HandlerResult.success(
        data: GetGroupResponse(
          id: group.id,
          name: group.name,
          description: group.description,
          imageUrl: group.imageUrl,
          createdBy: group.createdBy,
          createdAt: group.createdAt,
          updatedAt: group.updatedAt,
          memberCount: memberCount,
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
