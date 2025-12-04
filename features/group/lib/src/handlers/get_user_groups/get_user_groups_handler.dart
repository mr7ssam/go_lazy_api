import 'package:common/common.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class GetUserGroupsHandler
    extends IHandler<GetUserGroupsRequest, GetUserGroupsResponse> {
  GetUserGroupsHandler({
    required IGroupsRepo groupsRepo,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<GetUserGroupsResponse>> handle(
    GetUserGroupsRequest request,
  ) async {
    try {
      final groups = await _groupsRepo.getUserGroups(request.userId);

      final groupSummaries = groups.map((group) {
        return GroupSummary(
          id: group.id,
          name: group.name,
          description: group.description,
          imageUrl: group.imageUrl,
          createdBy: group.createdBy,
          createdAt: group.createdAt,
          updatedAt: group.updatedAt,
        );
      }).toList();

      return HandlerResult.success(
        data: GetUserGroupsResponse(groups: groupSummaries),
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
