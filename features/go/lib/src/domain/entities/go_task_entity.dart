import 'package:uuid/uuid.dart';

class GoTask {
  GoTask({
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
    this.updatedAt,
    this.completedBy,
    this.updatedBy,
  });

  factory GoTask.create({
    required String eventId,
    required String title,
    required String createdBy,
    String? description,
    DateTime? deadline,
    bool isPrivate = false,
  }) {
    return GoTask(
      id: const Uuid().v4(),
      eventId: eventId,
      title: title,
      description: description,
      deadline: deadline,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
      isDone: false,
      isPrivate: isPrivate,
      updatedBy: createdBy,
    );
  }

  final String id;
  final String eventId;
  final String title;
  final String? description;
  final DateTime? deadline;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? updatedAt;
  final bool isDone;
  final bool isPrivate;
  final String? completedBy;
  final String? updatedBy;

  GoTask copyWith({
    String? id,
    String? eventId,
    String? title,
    String? description,
    DateTime? deadline,
    String? createdBy,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? updatedAt,
    bool? isDone,
    bool? isPrivate,
    String? completedBy,
    String? updatedBy,
  }) {
    return GoTask(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDone: isDone ?? this.isDone,
      isPrivate: isPrivate ?? this.isPrivate,
      completedBy: completedBy ?? this.completedBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
