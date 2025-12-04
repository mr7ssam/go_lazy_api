import 'package:uuid/uuid.dart';

class Group {
  Group({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.isActive,
    this.description,
    this.imageUrl,
    this.updatedAt,
  });

  factory Group.create({
    required String name,
    required String createdBy,
    String? description,
    String? imageUrl,
  }) {
    return Group(
      id: const Uuid().v4(),
      name: name,
      description: description,
      imageUrl: imageUrl,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
      isActive: true,
    );
  }

  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  Group copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
