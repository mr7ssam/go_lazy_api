import 'package:common/common.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class GetGroupMembersHandler
    extends IHandler<GetGroupMembersRequest, GetGroupMembersResponse> {
  GetGroupMembersHandler({
    required IGroupsRepo groupsRepo,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<GetGroupMembersResponse>> handle(
    GetGroupMembersRequest request,
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

      final membersWithUsers = await _groupsRepo.getGroupMembers(
        request.groupId,
      );

      final members = membersWithUsers
          .where((m) => m.member.isActive)
          .map(
            (m) => MemberInfo(
              id: m.member.id,
              userId: m.user.id,
              firstName: m.user.firstName,
              lastName: m.user.lastName,
              email: m.user.email,
              phoneNumber: m.user.phoneNumber,
              role: m.member.role,
              joinedAt: m.member.joinedAt,
              photoUrl: m.user.photoUrl,
            ),
          )
          .toList();

      return HandlerResult.success(
        data: GetGroupMembersResponse(members: members),
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
