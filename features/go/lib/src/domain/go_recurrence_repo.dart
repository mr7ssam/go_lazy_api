import 'package:go/go_domain.dart';

abstract class IGoRecurrenceRepo {
  Future<GoRecurrence> createRecurrence(GoRecurrence recurrence);
  Future<GoRecurrence?> getRecurrenceByEventId(String eventId);
  Future<void> updateRecurrence(GoRecurrence recurrence);
  Future<void> deleteRecurrence(String id);
}
