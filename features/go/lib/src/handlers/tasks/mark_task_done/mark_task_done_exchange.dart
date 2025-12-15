class MarkTaskDoneRequest {
  const MarkTaskDoneRequest({
    required this.taskId,
    required this.userId,
    this.isDone = true,
  });

  final String taskId;
  final String userId;
  final bool isDone;
}
