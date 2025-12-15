import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class UpdateTaskHandler extends IHandler<UpdateTaskRequest, void> {
  UpdateTaskHandler({
    required IGoTasksRepo tasksRepo,
    required IGoParticipantsRepo participantsRepo,
    required TransactionManager transactionManager,
    required LocalizationService localization,
  })  : _tasksRepo = tasksRepo,
        _participantsRepo = participantsRepo,
        _transactionManager = transactionManager,
        _localization = localization;

  final IGoTasksRepo _tasksRepo;
  final IGoParticipantsRepo _participantsRepo;
  final TransactionManager _transactionManager;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<void>> handle(UpdateTaskRequest request) async {
    try {
      final task = await _tasksRepo.getTaskById(request.taskId);

      if (task == null) {
        return HandlerResult.failed(
          error:
              NotFoundError(message: _localization.translations.taskNotFound),
        );
      }

      // Check authorization: creator OR (shared AND participant)
      final isCreator = task.createdBy == request.userId;
      final isParticipant = await _participantsRepo.isUserParticipant(
        task.eventId,
        request.userId,
      );

      if (!isCreator && (task.isPrivate || !isParticipant)) {
        return HandlerResult.failed(
          error: UnauthorizedError(message: 'Access denied'),
        );
      }

      // Validate isPrivate toggle: cannot make shared task private
      if (request.isPrivate != null &&
          !task.isPrivate &&
          (request.isPrivate ?? false)) {
        return HandlerResult.failed(
          error: BadRequestError(
            message: 'Cannot make shared task private after'
                ' it has been shared with participants',
          ),
        );
      }

      // Update task
      final updatedTask = task.copyWith(
        title: request.title,
        description: request.description,
        deadline: request.deadline,
        isPrivate: request.isPrivate,
        updatedBy: request.userId,
        updatedAt: DateTime.now().toUtc(),
      );

      await _transactionManager.runInTransaction(() async {
        await _tasksRepo.updateTask(updatedTask);
      });

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
