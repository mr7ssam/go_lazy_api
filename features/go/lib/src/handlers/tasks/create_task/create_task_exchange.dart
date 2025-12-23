class CreateTaskRequest {
  const CreateTaskRequest({
    required this.eventId,
    required this.title,
    required this.createdBy,
    this.description,
    this.deadline,
    this.isPrivate = false,
  });

  factory CreateTaskRequest.fromJson(Map<String, dynamic> json) =>
      CreateTaskRequest(
        eventId: json['eventId'] as String,
        title: json['title'] as String,
        createdBy: json['createdBy'] as String,
        description: json['description'] as String?,
        deadline: json['deadline'] != null
            ? DateTime.parse(json['deadline'] as String)
            : null,
        isPrivate: json['isPrivate'] as bool? ?? false,
      );

  final String eventId;
  final String title;
  final String? description;
  final DateTime? deadline;
  final String createdBy;
  final bool isPrivate;

  CreateTaskRequest copyWith({
    String? eventId,
    String? title,
    String? description,
    DateTime? deadline,
    String? createdBy,
    bool? isPrivate,
  }) {
    return CreateTaskRequest(
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      createdBy: createdBy ?? this.createdBy,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}

class CreateTaskResponse {
  const CreateTaskResponse({
    required this.id,
    required this.eventId,
    required this.title,
    required this.createdBy,
    required this.createdAt,
    required this.isDone,
    this.description,
    this.deadline,
  });

  final String id;
  final String eventId;
  final String title;
  final String? description;
  final DateTime? deadline;
  final String createdBy;
  final DateTime createdAt;
  final bool isDone;

  Map<String, dynamic> toJson() => {
        'id': id,
        'eventId': eventId,
        'title': title,
        'description': description,
        'deadline': deadline?.toIso8601String(),
        'createdBy': createdBy,
        'createdAt': createdAt.toIso8601String(),
        'isDone': isDone,
      };
}
