import 'package:common/common.dart';
import 'package:go/go_domain.dart';
import 'package:go/src/handlers/events/get_event_progress/get_event_progress_exchange.dart';

class GetEventProgressHandler
    extends IHandler<String, GetEventProgressResponse> {
  GetEventProgressHandler({
    required IGoTasksRepo goTasksRepo,
    required IGoEventsRepo goEventsRepo,
    required LocalizationService localizationService,
  })  : _goTasksRepo = goTasksRepo,
        _goEventsRepo = goEventsRepo,
        _localizationService = localizationService;

  final IGoTasksRepo _goTasksRepo;
  final IGoEventsRepo _goEventsRepo;
  final LocalizationService _localizationService;

  @override
  Future<HandlerResult<GetEventProgressResponse>> handle(String eventId) async {
    try {
      // Check if event exists
      final event = await _goEventsRepo.getEventById(eventId);
      if (event == null) {
        return HandlerResult.failed(
          error: NotFoundError(
            message: _localizationService.translations.goEventNotFound,
          ),
        );
      }

      // Get all tasks for the event
      final tasks = await _goTasksRepo.getEventTasks(eventId);

      final totalTasks = tasks.length;
      final completedTasks = tasks.where((task) => task.isDone).length;
      final progressPercent =
          totalTasks > 0 ? ((completedTasks / totalTasks) * 100).round() : 0;

      // Get overdue tasks
      final now = DateTime.now().toUtc();
      final overdueTasks = tasks
          .where(
            (task) =>
                !task.isDone &&
                task.deadline != null &&
                task.deadline!.isBefore(now),
          )
          .map(
            (task) => OverdueTask(
              id: task.id,
              title: task.title,
              dueAt: task.deadline!,
              assignedTo: task.createdBy,
            ),
          )
          .toList();

      final response = GetEventProgressResponse(
        totalTasks: totalTasks,
        completedTasks: completedTasks,
        progressPercent: progressPercent,
        overdueTasks: overdueTasks,
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
