import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class UpdateReminderHandler
    extends IHandler<UpdateReminderRequest, UpdateReminderResponse> {
  UpdateReminderHandler({
    required IGoRemindersRepo remindersRepo,
    required TransactionManager transactionManager,
    required LocalizationService localization,
  })  : _remindersRepo = remindersRepo,
        _transactionManager = transactionManager,
        _localization = localization;

  final IGoRemindersRepo _remindersRepo;
  final TransactionManager _transactionManager;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<UpdateReminderResponse>> handle(
    UpdateReminderRequest request,
  ) async {
    try {
      // Verify reminder exists
      final reminder = await _remindersRepo.getReminderById(request.id);
      if (reminder == null) {
        return HandlerResult.failed(
          error: NotFoundError(
            message: _localization.translations.goReminderNotFound,
          ),
        );
      }

      // Verify user owns the reminder
      if (reminder.userId != request.userId) {
        return HandlerResult.failed(
          error: UnauthorizedError(
            message: _localization.translations.goTaskNotAssignedToYou,
          ),
        );
      }

      late GoReminder updatedReminder;

      await _transactionManager.runInTransaction(() async {
        updatedReminder = reminder.copyWith(
          reminderType: request.reminderType != null
              ? GoReminderType.fromString(request.reminderType!)
              : null,
          remindAt: request.remindAt,
          minutesBefore: request.minutesBefore,
        );

        await _remindersRepo.updateReminder(updatedReminder);
      });

      return HandlerResult.success(
        data: UpdateReminderResponse(
          id: updatedReminder.id,
          taskId: updatedReminder.taskId,
          userId: updatedReminder.userId,
          reminderType: updatedReminder.reminderType.value,
          remindAt: updatedReminder.remindAt,
          minutesBefore: updatedReminder.minutesBefore,
          isSent: updatedReminder.isSent,
          sentAt: updatedReminder.sentAt,
          createdAt: updatedReminder.createdAt,
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
