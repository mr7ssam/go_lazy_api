import 'package:group/group_handlers.dart';
import 'package:test/test.dart';

void main() {
  group('CreateGroupRequest', () {
    test('fromJson parses all fields correctly', () {
      final json = {
        'name': 'Test Group',
        'userId': 'user-123',
        'description': 'A test description',
        'imageUrl': 'https://example.com/image.png',
      };

      final request = CreateGroupRequest.fromJson(json);

      expect(request.name, equals('Test Group'));
      expect(request.userId, equals('user-123'));
      expect(request.description, equals('A test description'));
      expect(request.imageUrl, equals('https://example.com/image.png'));
    });

    test('fromJson handles null optional fields', () {
      final json = {
        'name': 'Test Group',
        'userId': 'user-123',
      };

      final request = CreateGroupRequest.fromJson(json);

      expect(request.name, equals('Test Group'));
      expect(request.userId, equals('user-123'));
      expect(request.description, isNull);
      expect(request.imageUrl, isNull);
    });

    test('copyWith updates specified fields', () {
      const original = CreateGroupRequest(
        name: 'Original Name',
        userId: 'user-123',
        description: 'Original Description',
        imageUrl: 'https://example.com/original.png',
      );

      final copied = original.copyWith(
        name: 'New Name',
        description: 'New Description',
      );

      expect(copied.name, equals('New Name'));
      expect(copied.userId, equals('user-123'));
      expect(copied.description, equals('New Description'));
      expect(copied.imageUrl, equals('https://example.com/original.png'));
    });

    test('copyWith preserves all fields when none specified', () {
      const original = CreateGroupRequest(
        name: 'Test Group',
        userId: 'user-123',
        description: 'Description',
        imageUrl: 'https://example.com/image.png',
      );

      final copied = original.copyWith();

      expect(copied.name, equals(original.name));
      expect(copied.userId, equals(original.userId));
      expect(copied.description, equals(original.description));
      expect(copied.imageUrl, equals(original.imageUrl));
    });
  });

  group('CreateGroupResponse', () {
    test('toJson serializes all fields correctly', () {
      final response = CreateGroupResponse(
        id: 'group-123',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        description: 'A test description',
        imageUrl: 'https://example.com/image.png',
      );

      final json = response.toJson();

      expect(json['id'], equals('group-123'));
      expect(json['name'], equals('Test Group'));
      expect(json['createdBy'], equals('user-123'));
      expect(json['createdAt'], equals('2025-01-01T12:00:00.000Z'));
      expect(json['description'], equals('A test description'));
      expect(json['imageUrl'], equals('https://example.com/image.png'));
    });

    test('toJson includes null optional fields', () {
      final response = CreateGroupResponse(
        id: 'group-123',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 1, 12),
      );

      final json = response.toJson();

      expect(json['description'], isNull);
      expect(json['imageUrl'], isNull);
    });
  });
}
