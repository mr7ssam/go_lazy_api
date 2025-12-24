import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class UpdateRecurrenceHandler extends IHandler<UpdateRecurrenceRequest, void> {
  UpdateRecurrenceHandler({required this.recurrenceRepo});

  final IGoRecurrenceRepo recurrenceRepo;

  @override
  Future<HandlerResult<void>> handle(UpdateRecurrenceRequest request) async {
    try {
      final existing =
          await recurrenceRepo.getRecurrenceByEventId(request.eventId);

      if (existing == null) {
        return HandlerResult.failed(
          error: NotFoundError(message: 'Recurrence rule not found'),
        );
      }

      final updated = existing.copyWith(
        frequency: request.frequency,
        interval: request.interval,
        daysOfWeek: request.daysOfWeek,
        dayOfMonth: request.dayOfMonth,
        weekOfMonth: request.weekOfMonth,
        dayOfWeekInMonth: request.dayOfWeekInMonth,
        endType: request.endType,
        endAfterCount: request.endAfterCount,
        endUntilDate: request.endUntilDate,
        taskMode: request.taskMode,
        updatedAt: DateTime.now().toUtc(),
      );

      await recurrenceRepo.updateRecurrence(updated);

      return const HandlerResult.success(data: null);
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(message: e.toString()),
      );
    }
  }
}
