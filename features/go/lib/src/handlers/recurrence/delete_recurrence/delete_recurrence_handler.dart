import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class DeleteRecurrenceHandler extends IHandler<DeleteRecurrenceRequest, void> {
  DeleteRecurrenceHandler({required this.recurrenceRepo});

  final IGoRecurrenceRepo recurrenceRepo;

  @override
  Future<HandlerResult<void>> handle(DeleteRecurrenceRequest request) async {
    try {
      final existing =
          await recurrenceRepo.getRecurrenceByEventId(request.eventId);

      if (existing == null) {
        return HandlerResult.failed(
          error: NotFoundError(message: 'Recurrence rule not found'),
        );
      }

      await recurrenceRepo.deleteRecurrence(existing.id);

      return const HandlerResult.success(data: null);
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(message: e.toString()),
      );
    }
  }
}
