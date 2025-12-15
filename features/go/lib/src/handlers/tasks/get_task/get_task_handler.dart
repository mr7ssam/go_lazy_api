import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class GetTaskHandler extends IHandler<GetTaskRequest, GetTaskResponse> {
  GetTaskHandler({
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
  Future<HandlerResult<GetTaskResponse>> handle(GetTaskRequest request) async {
    try {
      final task = await _tasksRepo.getTaskById(request.taskId);

      if (task == null) {
        return HandlerResult.failed(
          error:
              NotFoundError(message: _localization.translations.taskNotFound),
        );
      }

      // Check access: if task is private AND user is not creator,
      // verify user is participant
      if (task.isPrivate && task.createdBy != request.userId) {
        final isParticipant = await _participantsRepo.isUserParticipant(
          task.eventId,
          request.userId,
        );

        if (!isParticipant) {
          return HandlerResult.failed(
            error: UnauthorizedError(
              message: _localization.translations.accessDenied,
            ),
          );
        }

        // Private task and not creator - deny access even if participant
        return HandlerResult.failed(
          error: UnauthorizedError(
            message: _localization.translations.accessDenied,
          ),
        );
      }

      // For non-private tasks, verify user is participant
      if (!task.isPrivate) {
        final isParticipant = await _participantsRepo.isUserParticipant(
          task.eventId,
          request.userId,
        );

        if (!isParticipant) {
          return HandlerResult.failed(
            error: UnauthorizedError(
              message: _localization.translations.accessDenied,
            ),
          );
        }
      }

      return HandlerResult.success(
        data: GetTaskResponse(
          id: task.id,
          eventId: task.eventId,
          title: task.title,
          description: task.description,
          deadline: task.deadline,
          createdBy: task.createdBy,
          createdAt: task.createdAt,
          completedAt: task.completedAt,
          updatedAt: task.updatedAt,
          isDone: task.isDone,
          isPrivate: task.isPrivate,
          completedBy: task.completedBy,
          updatedBy: task.updatedBy,
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
