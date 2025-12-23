import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:uuid/uuid.dart';

class CreateReminderHandler
    extends IHandler<CreateReminderRequest, CreateReminderResponse> {
  CreateReminderHandler({
    required IGoRemindersRepo remindersRepo,
    required IGoTasksRepo tasksRepo,
    required TransactionManager transactionManager,
    required LocalizationService localization,
  })  : _remindersRepo = remindersRepo,
        _tasksRepo = tasksRepo,
        _transactionManager = transactionManager,
        _localization = localization;

  final IGoRemindersRepo _remindersRepo;
  final IGoTasksRepo _tasksRepo;
  final TransactionManager _transactionManager;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<CreateReminderResponse>> handle(
    CreateReminderRequest request,
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

      // Verify user is the task creator (only creator can set reminders)
      if (task.createdBy != request.userId) {
        return HandlerResult.failed(
          error: UnauthorizedError(
            message: _localization.translations.goTaskNotAssignedToYou,
          ),
        );
      }

      // Validate reminder type and required fields
      final reminderType = GoReminderType.fromString(request.reminderType);

      if (reminderType == GoReminderType.specificTime &&
          request.remindAt == null) {
        return HandlerResult.failed(
          error: BadRequestError(
            message: 'remindAt is required for specific_time reminder type',
          ),
        );
      }

      if ((reminderType == GoReminderType.timeBeforeEvent ||
              reminderType == GoReminderType.timeBeforeDeadline) &&
          request.minutesBefore == null) {
        return HandlerResult.failed(
          error: BadRequestError(
            message: 'minutesBefore is required for time-based reminder types',
          ),
        );
      }

      late GoReminder createdReminder;

      await _transactionManager.runInTransaction(() async {
        createdReminder = await _remindersRepo.createReminder(
          GoReminder(
            id: const Uuid().v4(),
            taskId: request.taskId,
            userId: request.userId,
            reminderType: reminderType,
            remindAt: request.remindAt,
            minutesBefore: request.minutesBefore,
            isSent: false,
            createdAt: DateTime.now().toUtc(),
          ),
        );
      });

      return HandlerResult.success(
        data: CreateReminderResponse(
          id: createdReminder.id,
          taskId: createdReminder.taskId,
          userId: createdReminder.userId,
          reminderType: createdReminder.reminderType.value,
          remindAt: createdReminder.remindAt,
          minutesBefore: createdReminder.minutesBefore,
          isSent: createdReminder.isSent,
          sentAt: createdReminder.sentAt,
          createdAt: createdReminder.createdAt,
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
