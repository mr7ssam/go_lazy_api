import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class GetRecurrenceHandler
    extends IHandler<GetRecurrenceRequest, GetRecurrenceResponse> {
  GetRecurrenceHandler({required this.recurrenceRepo});

  final IGoRecurrenceRepo recurrenceRepo;

  @override
  Future<HandlerResult<GetRecurrenceResponse>> handle(
    GetRecurrenceRequest request,
  ) async {
    try {
      final recurrence =
          await recurrenceRepo.getRecurrenceByEventId(request.eventId);

      return HandlerResult.success(
        data: GetRecurrenceResponse(recurrence: recurrence),
      );
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(message: e.toString()),
      );
    }
  }
}
