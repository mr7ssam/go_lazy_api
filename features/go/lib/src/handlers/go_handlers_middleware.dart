import 'package:common/common.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

export 'reminders/index.dart';
export 'tasks/index.dart';

extension HandlerUse on Handler {
  Handler registerGoHandlersMiddlewares() {
    return use(
      provider<CreateTaskHandler>(
        (context) => CreateTaskHandler(
          tasksRepo: context.read<IGoTasksRepo>(),
          participantsRepo: context.read<IGoParticipantsRepo>(),
          transactionManager: context.read<TransactionManager>(),
          localization: context.read<LocalizationService>(),
        ),
      ),
    )
        .use(
          provider<GetTaskHandler>(
            (context) => GetTaskHandler(
              tasksRepo: context.read<IGoTasksRepo>(),
              participantsRepo: context.read<IGoParticipantsRepo>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<GetEventTasksHandler>(
            (context) => GetEventTasksHandler(
              tasksRepo: context.read<IGoTasksRepo>(),
              participantsRepo: context.read<IGoParticipantsRepo>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<UpdateTaskHandler>(
            (context) => UpdateTaskHandler(
              tasksRepo: context.read<IGoTasksRepo>(),
              participantsRepo: context.read<IGoParticipantsRepo>(),
              transactionManager: context.read<TransactionManager>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<MarkTaskDoneHandler>(
            (context) => MarkTaskDoneHandler(
              tasksRepo: context.read<IGoTasksRepo>(),
              participantsRepo: context.read<IGoParticipantsRepo>(),
              transactionManager: context.read<TransactionManager>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<DeleteTaskHandler>(
            (context) => DeleteTaskHandler(
              tasksRepo: context.read<IGoTasksRepo>(),
              participantsRepo: context.read<IGoParticipantsRepo>(),
              transactionManager: context.read<TransactionManager>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<CreateReminderHandler>(
            (context) => CreateReminderHandler(
              remindersRepo: context.read<IGoRemindersRepo>(),
              tasksRepo: context.read<IGoTasksRepo>(),
              transactionManager: context.read<TransactionManager>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<UpdateReminderHandler>(
            (context) => UpdateReminderHandler(
              remindersRepo: context.read<IGoRemindersRepo>(),
              transactionManager: context.read<TransactionManager>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<DeleteReminderHandler>(
            (context) => DeleteReminderHandler(
              remindersRepo: context.read<IGoRemindersRepo>(),
              transactionManager: context.read<TransactionManager>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<GetTaskRemindersHandler>(
            (context) => GetTaskRemindersHandler(
              remindersRepo: context.read<IGoRemindersRepo>(),
              tasksRepo: context.read<IGoTasksRepo>(),
              localization: context.read<LocalizationService>(),
            ),
          ),
        )
        .use(
          provider<GetEventProgressHandler>(
            (context) => GetEventProgressHandler(
              goTasksRepo: context.read<IGoTasksRepo>(),
              goEventsRepo: context.read<IGoEventsRepo>(),
              localizationService: context.read<LocalizationService>(),
            ),
          ),
        );
  }
}
