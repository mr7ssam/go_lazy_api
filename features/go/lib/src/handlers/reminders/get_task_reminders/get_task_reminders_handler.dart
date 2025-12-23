import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class GetTaskRemindersHandler
    extends IHandler<GetTaskRemindersRequest, GetTaskRemindersResponse> {
  GetTaskRemindersHandler({
    required IGoRemindersRepo remindersRepo,
    required IGoTasksRepo tasksRepo,
    required LocalizationService localization,
  })  : _remindersRepo = remindersRepo,
        _tasksRepo = tasksRepo,
        _localization = localization;

  final IGoRemindersRepo _remindersRepo;
  final IGoTasksRepo _tasksRepo;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<GetTaskRemindersResponse>> handle(
    GetTaskRemindersRequest request,
  ) async {
    try {
      // Verify task exists
      final task = await _tasksRepo.getTaskById(request.taskId);
      if (task == null) {
        return HandlerResult.failed(
          error: NotFoundError(
            message: _localization.translations.goTaskNotFound,
          ),
        );
      }

      // Verify user is the task creator (only creator can see reminders)
      if (task.createdBy != request.userId) {
        return HandlerResult.failed(
          error: UnauthorizedError(
            message: _localization.translations.goTaskNotAssignedToYou,
          ),
        );
      }

      final reminders = await _remindersRepo.getTaskReminders(request.taskId);

      return HandlerResult.success(
        data: GetTaskRemindersResponse(
          reminders: reminders
              .map(
                (r) => ReminderDto(
                  id: r.id,
                  taskId: r.taskId,
                  userId: r.userId,
                  reminderType: r.reminderType.value,
                  remindAt: r.remindAt,
                  minutesBefore: r.minutesBefore,
                  isSent: r.isSent,
                  sentAt: r.sentAt,
                  createdAt: r.createdAt,
                ),
              )
              .toList(),
        ),
      );
    } on BadRequestError catch (e) {
      return HandlerResult.failed(error: e);
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(
          message: _localization.translations.internalServerError,
        ),
      );
    }
  }
}
