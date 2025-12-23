import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class MarkTaskDoneHandler extends IHandler<MarkTaskDoneRequest, void> {
  MarkTaskDoneHandler({
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
  Future<HandlerResult<void>> handle(MarkTaskDoneRequest request) async {
    try {
      final task = await _tasksRepo.getTaskById(request.taskId);

      if (task == null) {
        return HandlerResult.failed(
          error: NotFoundError(
            message: _localization.translations.taskNotFound,
          ),
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
          error: UnauthorizedError(
            message: _localization.translations.accessDenied,
          ),
        );
      }

      // Update task completion status
      final now = DateTime.now().toUtc();
      final updatedTask = task.copyWith(
        isDone: request.isDone,
        completedBy: request.isDone ? request.userId : task.completedBy,
        completedAt: request.isDone ? now : null,
        updatedBy: request.userId,
        updatedAt: now,
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
