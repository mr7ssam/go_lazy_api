import 'package:go/go_domain.dart';

class CreateRecurrenceRequest {
  const CreateRecurrenceRequest({
    required this.eventId,
    required this.frequency,
    required this.interval,
    required this.endType,
    required this.taskMode,
    this.daysOfWeek,
    this.dayOfMonth,
    this.weekOfMonth,
    this.dayOfWeekInMonth,
    this.endAfterCount,
    this.endUntilDate,
  });

  factory CreateRecurrenceRequest.fromJson(Map<String, dynamic> json) {
    return CreateRecurrenceRequest(
      eventId: json['eventId'] as String,
      frequency: GoFrequency.values.byName(json['frequency'] as String),
      interval: json['interval'] as int? ?? 1,
      daysOfWeek: (json['daysOfWeek'] as List?)?.cast<String>(),
      dayOfMonth: json['dayOfMonth'] as int?,
      weekOfMonth: json['weekOfMonth'] as int?,
      dayOfWeekInMonth: json['dayOfWeekInMonth'] as String?,
      endType: GoEndType.values.byName(json['endType'] as String),
      endAfterCount: json['endAfterCount'] as int?,
      endUntilDate: json['endUntilDate'] != null
          ? DateTime.parse(json['endUntilDate'] as String)
          : null,
      taskMode: json['taskMode'] != null
          ? GoTaskMode.values.byName(json['taskMode'] as String)
          : GoTaskMode.copy,
    );
  }
  final String eventId;
  final GoFrequency frequency;
  final int interval;
  final List<String>? daysOfWeek;
  final int? dayOfMonth;
  final int? weekOfMonth;
  final String? dayOfWeekInMonth;
  final GoEndType endType;
  final int? endAfterCount;
  final DateTime? endUntilDate;
  final GoTaskMode taskMode;
}

class CreateRecurrenceResponse {
  const CreateRecurrenceResponse({required this.recurrence});
  final GoRecurrence recurrence;

  Map<String, dynamic> toJson() {
    return {
      'recurrence': {
        'id': recurrence.id,
        'eventId': recurrence.eventId,
        'frequency': recurrence.frequency.name,
        'interval': recurrence.interval,
        'daysOfWeek': recurrence.daysOfWeek,
        'dayOfMonth': recurrence.dayOfMonth,
        'weekOfMonth': recurrence.weekOfMonth,
        'dayOfWeekInMonth': recurrence.dayOfWeekInMonth,
        'endType': recurrence.endType.name,
        'endAfterCount': recurrence.endAfterCount,
        'endUntilDate': recurrence.endUntilDate?.toIso8601String(),
        'taskMode': recurrence.taskMode.name,
        'createdAt': recurrence.createdAt.toIso8601String(),
        'updatedAt': recurrence.updatedAt?.toIso8601String(),
      },
    };
  }
}
