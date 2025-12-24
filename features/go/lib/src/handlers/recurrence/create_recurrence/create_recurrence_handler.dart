import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:uuid/uuid.dart';

class CreateRecurrenceHandler
    extends IHandler<CreateRecurrenceRequest, CreateRecurrenceResponse> {
  CreateRecurrenceHandler({
    required this.recurrenceRepo,
    required this.eventsRepo,
  });

  final IGoRecurrenceRepo recurrenceRepo;
  final IGoEventsRepo eventsRepo;

  @override
  Future<HandlerResult<CreateRecurrenceResponse>> handle(
    CreateRecurrenceRequest request,
  ) async {
    try {
      final event = await eventsRepo.getEventById(request.eventId);
      if (event == null) {
        return HandlerResult.failed(
          error: NotFoundError(message: 'Event not found'),
        );
      }

      final existing =
          await recurrenceRepo.getRecurrenceByEventId(request.eventId);
      if (existing != null) {
        return HandlerResult.failed(
          error: ConflictError(
            message: 'Event already has a recurrence rule',
          ),
        );
      }

      final now = DateTime.now().toUtc();
      final recurrence = GoRecurrence(
        id: const Uuid().v4(),
        eventId: request.eventId,
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
        createdAt: now,
      );

      final created = await recurrenceRepo.createRecurrence(recurrence);

      return HandlerResult.success(
        data: CreateRecurrenceResponse(recurrence: created),
      );
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(message: e.toString()),
      );
    }
  }
}
