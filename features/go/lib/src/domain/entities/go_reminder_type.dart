/// Type of reminder for a task
enum GoReminderType {
  /// Remind X minutes before the event starts
  timeBeforeEvent('time_before_event'),

  /// Remind X minutes before the task deadline
  timeBeforeDeadline('time_before_deadline'),

  /// Remind at a specific date/time
  specificTime('specific_time');

  const GoReminderType(this.value);

  final String value;

  static GoReminderType fromString(String value) {
    return GoReminderType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError('Invalid reminder type: $value'),
    );
  }
}
