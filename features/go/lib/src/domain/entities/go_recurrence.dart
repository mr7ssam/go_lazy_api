import 'package:go/go_domain.dart';

class GoRecurrence {
  const GoRecurrence({
    required this.id,
    required this.eventId,
    required this.frequency,
    required this.interval,
    required this.endType,
    required this.taskMode,
    required this.createdAt,
    this.daysOfWeek,
    this.dayOfMonth,
    this.weekOfMonth,
    this.dayOfWeekInMonth,
    this.endAfterCount,
    this.endUntilDate,
    this.updatedAt,
  });
  final String id;
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
  final DateTime createdAt;
  final DateTime? updatedAt;

  GoRecurrence copyWith({
    String? id,
    String? eventId,
    GoFrequency? frequency,
    int? interval,
    List<String>? daysOfWeek,
    int? dayOfMonth,
    int? weekOfMonth,
    String? dayOfWeekInMonth,
    GoEndType? endType,
    int? endAfterCount,
    DateTime? endUntilDate,
    GoTaskMode? taskMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GoRecurrence(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      frequency: frequency ?? this.frequency,
      interval: interval ?? this.interval,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      weekOfMonth: weekOfMonth ?? this.weekOfMonth,
      dayOfWeekInMonth: dayOfWeekInMonth ?? this.dayOfWeekInMonth,
      endType: endType ?? this.endType,
      endAfterCount: endAfterCount ?? this.endAfterCount,
      endUntilDate: endUntilDate ?? this.endUntilDate,
      taskMode: taskMode ?? this.taskMode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
