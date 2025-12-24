import 'package:go/go_domain.dart';

class UpdateRecurrenceRequest {
  const UpdateRecurrenceRequest({
    required this.eventId,
    this.frequency,
    this.interval,
    this.daysOfWeek,
    this.dayOfMonth,
    this.weekOfMonth,
    this.dayOfWeekInMonth,
    this.endType,
    this.endAfterCount,
    this.endUntilDate,
    this.taskMode,
  });

  factory UpdateRecurrenceRequest.fromJson(
    Map<String, dynamic> json, {
    required String eventId,
  }) {
    return UpdateRecurrenceRequest(
      eventId: eventId,
      frequency: json['frequency'] != null
          ? GoFrequency.values.byName(json['frequency'] as String)
          : null,
      interval: json['interval'] as int?,
      daysOfWeek: (json['daysOfWeek'] as List?)?.cast<String>(),
      dayOfMonth: json['dayOfMonth'] as int?,
      weekOfMonth: json['weekOfMonth'] as int?,
      dayOfWeekInMonth: json['dayOfWeekInMonth'] as String?,
      endType: json['endType'] != null
          ? GoEndType.values.byName(json['endType'] as String)
          : null,
      endAfterCount: json['endAfterCount'] as int?,
      endUntilDate: json['endUntilDate'] != null
          ? DateTime.parse(json['endUntilDate'] as String)
          : null,
      taskMode: json['taskMode'] != null
          ? GoTaskMode.values.byName(json['taskMode'] as String)
          : null,
    );
  }
  final String eventId;
  final GoFrequency? frequency;
  final int? interval;
  final List<String>? daysOfWeek;
  final int? dayOfMonth;
  final int? weekOfMonth;
  final String? dayOfWeekInMonth;
  final GoEndType? endType;
  final int? endAfterCount;
  final DateTime? endUntilDate;
  final GoTaskMode? taskMode;
}
