class DeleteTaskRequest {
  const DeleteTaskRequest({
    required this.taskId,
    required this.userId,
  });

  final String taskId;
  final String userId;
}
