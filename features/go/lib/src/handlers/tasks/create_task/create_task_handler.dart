import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:go/go_domain.dart';
import 'package:go/go_handlers.dart';

class CreateTaskHandler
    extends IHandler<CreateTaskRequest, CreateTaskResponse> {
  CreateTaskHandler({
    required IGoTasksRepo tasksRepo,
    required IGoParticipantsRepo participantsRepo,
    required TransactionManager transactionManager,
    required LocalizationService localization,
  })  : _tasksRepo = tasksRepo,
        _participantsRepo = participantsRepo,
        _transactionManager = transactionManager,
        _localization = localization;

  final IGoTasksRepo _tasksRepo;
  final IGoParticipantsRepo _participantsRepo;
  final TransactionManager _transactionManager;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<CreateTaskResponse>> handle(
    CreateTaskRequest request,
  ) async {
    try {
      final userId = request.createdBy;
      final isParticipant = await _participantsRepo.isUserParticipant(
        request.eventId,
        userId,
      );

      if (!isParticipant) {
        return HandlerResult.failed(
          error: UnauthorizedError(
            message: _localization.translations.mustBeParticipantToCreate,
          ),
        );
      }

      late GoTask createdTask;

      await _transactionManager.runInTransaction(() async {
        createdTask = await _tasksRepo.createTask(
          GoTask.create(
            eventId: request.eventId,
            title: request.title,
            createdBy: request.createdBy,
            description: request.description,
            deadline: request.deadline,
            isPrivate: request.isPrivate,
          ),
        );
      });

      return HandlerResult.success(
        data: CreateTaskResponse(
          id: createdTask.id,
          eventId: createdTask.eventId,
          title: createdTask.title,
          description: createdTask.description,
          deadline: createdTask.deadline,
          createdBy: createdTask.createdBy,
          createdAt: createdTask.createdAt,
          isDone: createdTask.isDone,
        ),
      );
    } on BadRequestError catch (e) {
      return HandlerResult.failed(error: e);
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(
          message: _localization.translations.internalServerError,
        ),
      );
    }
  }
}
