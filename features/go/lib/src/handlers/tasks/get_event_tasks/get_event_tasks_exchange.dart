class GetEventTasksRequest {
  const GetEventTasksRequest({
    required this.eventId,
    required this.userId,
  });

  final String eventId;
  final String userId;
}

class TaskItem {
  const TaskItem({
    required this.id,
    required this.eventId,
    required this.title,
    required this.createdBy,
    required this.createdAt,
    required this.isDone,
    required this.isPrivate,
    this.description,
    this.deadline,
    this.completedAt,
    this.completedBy,
    this.updatedBy,
  });

  final String id;
  final String eventId;
  final String title;
  final String? description;
  final DateTime? deadline;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? completedAt;
  final bool isDone;
  final bool isPrivate;
  final String? completedBy;
  final String? updatedBy;

  Map<String, dynamic> toJson() => {
        'id': id,
        'eventId': eventId,
        'title': title,
        'description': description,
        'deadline': deadline?.toIso8601String(),
        'createdBy': createdBy,
        'createdAt': createdAt.toIso8601String(),
        'completedAt': completedAt?.toIso8601String(),
        'isDone': isDone,
        'isPrivate': isPrivate,
        'completedBy': completedBy,
        'updatedBy': updatedBy,
      };
}

class GetEventTasksResponse {
  const GetEventTasksResponse({
    required this.tasks,
  });

  final List<TaskItem> tasks;

  Map<String, dynamic> toJson() => {
        'tasks': tasks.map((t) => t.toJson()).toList(),
      };
}
