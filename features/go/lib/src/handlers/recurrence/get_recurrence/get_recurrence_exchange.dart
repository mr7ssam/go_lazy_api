import 'package:go/go_domain.dart';

class GetRecurrenceRequest {
  const GetRecurrenceRequest({required this.eventId});
  final String eventId;
}

class GetRecurrenceResponse {
  const GetRecurrenceResponse({this.recurrence});
  final GoRecurrence? recurrence;

  Map<String, dynamic> toJson() {
    if (recurrence == null) {
      return {};
    }

    return {
      'recurrence': {
        'id': recurrence!.id,
        'eventId': recurrence!.eventId,
        'frequency': recurrence!.frequency.name,
        'interval': recurrence!.interval,
        'daysOfWeek': recurrence!.daysOfWeek,
        'dayOfMonth': recurrence!.dayOfMonth,
        'weekOfMonth': recurrence!.weekOfMonth,
        'dayOfWeekInMonth': recurrence!.dayOfWeekInMonth,
        'endType': recurrence!.endType.name,
        'endAfterCount': recurrence!.endAfterCount,
        'endUntilDate': recurrence!.endUntilDate?.toIso8601String(),
        'taskMode': recurrence!.taskMode.name,
        'createdAt': recurrence!.createdAt.toIso8601String(),
        'updatedAt': recurrence!.updatedAt?.toIso8601String(),
      },
    };
  }
}
