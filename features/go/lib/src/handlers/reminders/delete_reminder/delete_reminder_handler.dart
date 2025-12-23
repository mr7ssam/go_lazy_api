import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class DeleteReminderHandler extends IHandler<DeleteReminderRequest, void> {
  DeleteReminderHandler({
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
  Future<HandlerResult<void>> handle(DeleteReminderRequest request) async {
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

      await _transactionManager.runInTransaction(() async {
        await _remindersRepo.deleteReminder(request.id);
      });

      return const HandlerResult.success(data: null);
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
