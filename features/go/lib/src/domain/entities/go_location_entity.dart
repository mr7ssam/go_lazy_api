import 'package:uuid/uuid.dart';

class GoLocation {
  GoLocation({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.isActive,
    this.address,
    this.latitude,
    this.longitude,
    this.googleMapsUrl,
    this.updatedAt,
  });

  factory GoLocation.create({
    required String name,
    required String createdBy,
    String? address,
    double? latitude,
    double? longitude,
    String? googleMapsUrl,
  }) {
    return GoLocation(
      id: const Uuid().v4(),
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      googleMapsUrl: googleMapsUrl,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
      isActive: true,
    );
  }

  final String id;
  final String name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? googleMapsUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  GoLocation copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? googleMapsUrl,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return GoLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      googleMapsUrl: googleMapsUrl ?? this.googleMapsUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
