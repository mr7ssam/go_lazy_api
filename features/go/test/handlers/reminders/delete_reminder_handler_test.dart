import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGoRemindersRepo extends Mock implements IGoRemindersRepo {}

class _MockTransactionManager extends Mock implements TransactionManager {}

void main() {
  late _MockGoRemindersRepo remindersRepo;
  late _MockTransactionManager transactionManager;
  late LocalizationService localization;
  late DeleteReminderHandler handler;

  setUpAll(() {
    Future<void> transactionCallback() async {}
    registerFallbackValue(transactionCallback);
  });

  setUp(() {
    remindersRepo = _MockGoRemindersRepo();
    transactionManager = _MockTransactionManager();
    localization = LocalizationService();
    handler = DeleteReminderHandler(
      remindersRepo: remindersRepo,
      transactionManager: transactionManager,
      localization: localization,
    );

    when(() => transactionManager.runInTransaction(any())).thenAnswer(
      (invocation) async {
        final callback =
            invocation.positionalArguments.first as Future<void> Function();
        return callback();
      },
    );
  });

  group('DeleteReminderHandler', () {
    test('deletes reminder successfully when user is owner', () async {
      final existingReminder = GoReminder(
        id: 'reminder-123',
        taskId: 'task-123',
        userId: 'user-123',
        reminderType: GoReminderType.timeBeforeDeadline,
        minutesBefore: 30,
        isSent: false,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => remindersRepo.getReminderById('reminder-123')).thenAnswer(
        (_) async => existingReminder,
      );

      when(() => remindersRepo.deleteReminder('reminder-123')).thenAnswer(
        (_) async {},
      );

      final result = await handler.handle(
        const DeleteReminderRequest(
          id: 'reminder-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (data) {
          // Success - no data returned
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => remindersRepo.getReminderById('reminder-123')).called(1);
      verify(() => remindersRepo.deleteReminder('reminder-123')).called(1);
    });

    test('returns NotFoundError when reminder does not exist', () async {
      when(() => remindersRepo.getReminderById('nonexistent-reminder'))
          .thenAnswer(
        (_) async => null,
      );

      final result = await handler.handle(
        const DeleteReminderRequest(
          id: 'nonexistent-reminder',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
        },
      );

      verify(() => remindersRepo.getReminderById('nonexistent-reminder'))
          .called(1);
      verifyNever(() => remindersRepo.deleteReminder(any()));
    });

    test('returns UnauthorizedError when user is not reminder owner',
        () async {
      final existingReminder = GoReminder(
        id: 'reminder-123',
        taskId: 'task-123',
        userId: 'other-user',
        reminderType: GoReminderType.timeBeforeDeadline,
        minutesBefore: 30,
        isSent: false,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => remindersRepo.getReminderById('reminder-123')).thenAnswer(
        (_) async => existingReminder,
      );

      final result = await handler.handle(
        const DeleteReminderRequest(
          id: 'reminder-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<UnauthorizedError>());
        },
      );

      verifyNever(() => remindersRepo.deleteReminder(any()));
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      final existingReminder = GoReminder(
        id: 'reminder-123',
        taskId: 'task-123',
        userId: 'user-123',
        reminderType: GoReminderType.timeBeforeDeadline,
        minutesBefore: 30,
        isSent: false,
        createdAt: DateTime.utc(2025, 1, 15),
      );

      when(() => remindersRepo.getReminderById('reminder-123')).thenAnswer(
        (_) async => existingReminder,
      );

      when(() => remindersRepo.deleteReminder('reminder-123')).thenThrow(
        Exception('Database error'),
      );

      final result = await handler.handle(
        const DeleteReminderRequest(
          id: 'reminder-123',
          userId: 'user-123',
        ),
      );

      result.when(
        success: (_) => fail('Expected failure, got success'),
        failed: (error) {
          expect(error, isA<InternalServerError>());
        },
      );
    });
  });
}
