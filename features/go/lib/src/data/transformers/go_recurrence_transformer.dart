import 'dart:convert';

import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';

class GoRecurrenceInputTransformer {
  static GoRecurrenceRulesTableCompanion transform(GoRecurrence recurrence) {
    return GoRecurrenceRulesTableCompanion(
      id: Value(recurrence.id),
      eventId: Value(recurrence.eventId),
      frequency: Value(recurrence.frequency.name),
      interval: Value(recurrence.interval),
      daysOfWeek: Value(
        recurrence.daysOfWeek != null
            ? jsonEncode(recurrence.daysOfWeek)
            : null,
      ),
      dayOfMonth: Value(recurrence.dayOfMonth),
      weekOfMonth: Value(recurrence.weekOfMonth),
      dayOfWeekInMonth: Value(recurrence.dayOfWeekInMonth),
      endType: Value(recurrence.endType.name),
      endAfterCount: Value(recurrence.endAfterCount),
      endUntilDate: Value(recurrence.endUntilDate),
      taskMode: Value(recurrence.taskMode.name),
      createdAt: Value(recurrence.createdAt),
      updatedAt: Value(recurrence.updatedAt),
    );
  }

  static GoRecurrenceRulesTableData toTableData(GoRecurrence recurrence) {
    return GoRecurrenceRulesTableData(
      id: recurrence.id,
      eventId: recurrence.eventId,
      frequency: recurrence.frequency.name,
      interval: recurrence.interval,
      daysOfWeek: recurrence.daysOfWeek != null
          ? jsonEncode(recurrence.daysOfWeek)
          : null,
      dayOfMonth: recurrence.dayOfMonth,
      weekOfMonth: recurrence.weekOfMonth,
      dayOfWeekInMonth: recurrence.dayOfWeekInMonth,
      endType: recurrence.endType.name,
      endAfterCount: recurrence.endAfterCount,
      endUntilDate: recurrence.endUntilDate,
      taskMode: recurrence.taskMode.name,
      createdAt: recurrence.createdAt,
      updatedAt: recurrence.updatedAt,
    );
  }
}

class GoRecurrenceOutputTransformer {
  static GoRecurrence transform(GoRecurrenceRulesTableData data) {
    return GoRecurrence(
      id: data.id,
      eventId: data.eventId,
      frequency: GoFrequency.values.firstWhere(
        (e) => e.name == data.frequency,
      ),
      interval: data.interval,
      daysOfWeek: data.daysOfWeek != null
          ? (jsonDecode(data.daysOfWeek!) as List).cast<String>()
          : null,
      dayOfMonth: data.dayOfMonth,
      weekOfMonth: data.weekOfMonth,
      dayOfWeekInMonth: data.dayOfWeekInMonth,
      endType: GoEndType.values.firstWhere(
        (e) => e.name == data.endType,
      ),
      endAfterCount: data.endAfterCount,
      endUntilDate: data.endUntilDate,
      taskMode: GoTaskMode.values.firstWhere(
        (e) => e.name == data.taskMode,
      ),
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
