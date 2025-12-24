import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/src/handlers/events/get_event_feed/get_event_feed_exchange.dart';

class GetEventFeedHandler
    extends IHandler<GetEventFeedRequest, GetEventFeedResponse> {
  GetEventFeedHandler({
    required IGoEventsRepo goEventsRepo,
    required LocalizationService localizationService,
  })  : _goEventsRepo = goEventsRepo,
        _localizationService = localizationService;

  final IGoEventsRepo _goEventsRepo;
  final LocalizationService _localizationService;

  @override
  Future<HandlerResult<GetEventFeedResponse>> handle(
    GetEventFeedRequest request,
  ) async {
    try {
      // Validate limit
      if (request.limit <= 0 || request.limit > 100) {
        return HandlerResult.failed(
          error: BadRequestError(
            message: 'Limit must be between 1 and 100',
          ),
        );
      }

      // Validate offset
      if (request.offset < 0) {
        return HandlerResult.failed(
          error: BadRequestError(
            message: 'Offset must be non-negative',
          ),
        );
      }

      // Validate date range
      if (request.startDate != null &&
          request.endDate != null &&
          request.endDate!.isBefore(request.startDate!)) {
        return HandlerResult.failed(
          error: BadRequestError(
            message: 'End date must be after start date',
          ),
        );
      }

      // Fetch public events
      final events = await _goEventsRepo.getPublicEvents(
        startDate: request.startDate,
        endDate: request.endDate,
        limit: request.limit + 1, // Fetch one extra to check if there are more
        offset: request.offset,
      );

      // Check if there are more events
      final hasMore = events.length > request.limit;
      final eventsToReturn =
          hasMore ? events.sublist(0, request.limit) : events;

      // Convert to summary
      final eventSummaries =
          eventsToReturn.map(EventSummary.fromGoEvent).toList();

      final response = GetEventFeedResponse(
        events: eventSummaries,
        total: eventsToReturn.length,
        hasMore: hasMore,
      );

      return HandlerResult.success(data: response);
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(
          message: _localizationService.translations.internalServerError,
        ),
      );
    }
  }
}
