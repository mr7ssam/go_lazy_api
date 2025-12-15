import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class GetEventTasksHandler
    extends IHandler<GetEventTasksRequest, GetEventTasksResponse> {
  GetEventTasksHandler({
    required IGoTasksRepo tasksRepo,
    required IGoParticipantsRepo participantsRepo,
    required LocalizationService localization,
  })  : _tasksRepo = tasksRepo,
        _participantsRepo = participantsRepo,
        _localization = localization;

  final IGoTasksRepo _tasksRepo;
  final IGoParticipantsRepo _participantsRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<GetEventTasksResponse>> handle(
    GetEventTasksRequest request,
  ) async {
    try {
      // Validate user is participant
      final isParticipant = await _participantsRepo.isUserParticipant(
        request.eventId,
        request.userId,
      );

      if (!isParticipant) {
        return HandlerResult.failed(
          error: UnauthorizedError(
            message: _localization.translations.mustBeParticipantToView,
          ),
        );
      }

      final tasks = await _tasksRepo.getEventTasks(request.eventId);

      final visibleTasks = tasks
          .where(
            (task) => task.createdBy == request.userId || !task.isPrivate,
          )
          .map(
            (task) => TaskItem(
              id: task.id,
              eventId: task.eventId,
              title: task.title,
              description: task.description,
              deadline: task.deadline,
              createdBy: task.createdBy,
              createdAt: task.createdAt,
              completedAt: task.completedAt,
              isDone: task.isDone,
              isPrivate: task.isPrivate,
              completedBy: task.completedBy,
              updatedBy: task.updatedBy,
            ),
          )
          .toList();

      return HandlerResult.success(
        data: GetEventTasksResponse(tasks: visibleTasks),
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
