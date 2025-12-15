class UpdateTaskRequest {
  const UpdateTaskRequest({
    required this.taskId,
    required this.userId,
    this.title,
    this.description,
    this.category,
    this.deadline,
    this.isPrivate,
  });

  factory UpdateTaskRequest.fromJson(Map<String, dynamic> json) =>
      UpdateTaskRequest(
        taskId: json['taskId'] as String,
        userId: json['userId'] as String,
        title: json['title'] as String?,
        description: json['description'] as String?,
        category: json['category'] as String?,
        deadline: json['deadline'] != null
            ? DateTime.parse(json['deadline'] as String)
            : null,
        isPrivate: json['isPrivate'] as bool?,
      );

  final String taskId;
  final String userId;
  final String? title;
  final String? description;
  final String? category;
  final DateTime? deadline;
  final bool? isPrivate;

  UpdateTaskRequest copyWith({
    String? taskId,
    String? userId,
    String? title,
    String? description,
    String? category,
    DateTime? deadline,
    bool? isPrivate,
  }) {
    return UpdateTaskRequest(
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      deadline: deadline ?? this.deadline,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}
