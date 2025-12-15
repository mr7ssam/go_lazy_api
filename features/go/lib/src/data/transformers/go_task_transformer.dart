import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';

class GoTaskInputTransformer {
  static Insertable<GoTasksTableData> transform(GoTask task) {
    return GoTasksTableCompanion(
      id: Value(task.id),
      eventId: Value(task.eventId),
      title: Value(task.title),
      description: Value(task.description),
      deadline: Value(task.deadline),
      createdBy: Value(task.createdBy),
      createdAt: Value(task.createdAt),
      completedAt: Value(task.completedAt),
      updatedAt: Value(task.updatedAt),
      isDone: Value(task.isDone),
      isPrivate: Value(task.isPrivate),
      completedBy: Value(task.completedBy),
      updatedBy: Value(task.updatedBy),
    );
  }
}

class GoTaskOutputTransformer {
  static GoTask transform(GoTasksTableData data) {
    return GoTask(
      id: data.id,
      eventId: data.eventId,
      title: data.title,
      description: data.description,
      deadline: data.deadline,
      createdBy: data.createdBy,
      createdAt: data.createdAt,
      completedAt: data.completedAt,
      updatedAt: data.updatedAt,
      isDone: data.isDone,
      isPrivate: data.isPrivate,
      completedBy: data.completedBy,
      updatedBy: data.updatedBy,
    );
  }
}
