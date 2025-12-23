class GetEventProgressResponse {
  GetEventProgressResponse({
    required this.totalTasks,
    required this.completedTasks,
    required this.progressPercent,
    required this.overdueTasks,
  });

  final int totalTasks;
  final int completedTasks;
  final int progressPercent;
  final List<OverdueTask> overdueTasks;

  Map<String, dynamic> toJson() => {
        'totalTasks': totalTasks,
        'completedTasks': completedTasks,
        'progressPercent': progressPercent,
        'overdueTasks': overdueTasks.map((task) => task.toJson()).toList(),
      };
}

class OverdueTask {
  OverdueTask({
    required this.id,
    required this.title,
    required this.dueAt,
    this.assignedTo,
  });

  final String id;
  final String title;
  final DateTime dueAt;
  final String? assignedTo;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'dueAt': dueAt.toIso8601String(),
        'assignedTo': assignedTo,
      };
}
