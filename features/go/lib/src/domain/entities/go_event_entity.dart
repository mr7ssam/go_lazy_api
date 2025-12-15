import 'package:uuid/uuid.dart';

class GoEvent {
  GoEvent({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.createdAt,
    required this.startDate,
    required this.isActive,
    this.description,
    this.locationId,
    this.endDate,
    this.groupId,
    this.coverImageUrl,
    this.updatedAt,
  });

  factory GoEvent.create({
    required String title,
    required String createdBy,
    required DateTime startDate,
    String? description,
    String? locationId,
    DateTime? endDate,
    String? groupId,
    String? coverImageUrl,
  }) {
    return GoEvent(
      id: const Uuid().v4(),
      title: title,
      description: description,
      locationId: locationId,
      startDate: startDate,
      endDate: endDate,
      groupId: groupId,
      coverImageUrl: coverImageUrl,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
      isActive: true,
    );
  }

  final String id;
  final String title;
  final String? description;
  final String? locationId;
  final DateTime startDate;
  final DateTime? endDate;
  final String? groupId;
  final String? coverImageUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  GoEvent copyWith({
    String? id,
    String? title,
    String? description,
    String? locationId,
    DateTime? startDate,
    DateTime? endDate,
    String? groupId,
    String? coverImageUrl,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return GoEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      locationId: locationId ?? this.locationId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      groupId: groupId ?? this.groupId,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
