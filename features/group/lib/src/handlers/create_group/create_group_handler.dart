import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:group/group_domain.dart';
import 'package:group/group_handlers.dart';

class CreateGroupHandler
    extends IHandler<CreateGroupRequest, CreateGroupResponse> {
  CreateGroupHandler({
    required IGroupsRepo groupsRepo,
    required TransactionManager transactionManager,
    required LocalizationService localization,
  })  : _groupsRepo = groupsRepo,
        _transactionManager = transactionManager,
        _localization = localization;

  final IGroupsRepo _groupsRepo;
  final TransactionManager _transactionManager;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<CreateGroupResponse>> handle(
    CreateGroupRequest request,
  ) async {
    final userId = request.userId;
    try {
      late Group createdGroup;
      await _transactionManager.runInTransaction(() async {
        // Create the group
        createdGroup = await _groupsRepo.createGroup(
          Group.create(
            name: request.name,
            description: request.description,
            imageUrl: request.imageUrl,
            createdBy: userId,
          ),
        );

        // Add creator as owner
        await _groupsRepo.addMember(
          GroupMember.create(
            groupId: createdGroup.id,
            userId: userId,
            role: GroupMemberRoleEnum.owner,
          ),
        );
      });

      return HandlerResult.success(
        data: CreateGroupResponse(
          id: createdGroup.id,
          name: createdGroup.name,
          description: createdGroup.description,
          imageUrl: createdGroup.imageUrl,
          createdBy: createdGroup.createdBy,
          createdAt: createdGroup.createdAt,
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
