import 'package:group/group_domain.dart';
import 'package:test/test.dart';

void main() {
  group('Group', () {
    test('create factory generates valid Group', () {
      final group = Group.create(
        name: 'Test Group',
        createdBy: 'user-123',
        description: 'A test description',
        imageUrl: 'https://example.com/image.png',
      );

      expect(group.id, isNotEmpty);
      expect(group.name, equals('Test Group'));
      expect(group.description, equals('A test description'));
      expect(group.imageUrl, equals('https://example.com/image.png'));
      expect(group.createdBy, equals('user-123'));
      expect(group.createdAt, isNotNull);
      expect(group.isActive, isTrue);
      expect(group.updatedAt, isNull);
    });

    test('create factory generates unique ids', () {
      final group1 = Group.create(
        name: 'Group 1',
        createdBy: 'user-123',
      );
      final group2 = Group.create(
        name: 'Group 2',
        createdBy: 'user-123',
      );

      expect(group1.id, isNot(equals(group2.id)));
    });

    test('create factory handles null optional fields', () {
      final group = Group.create(
        name: 'Test Group',
        createdBy: 'user-123',
      );

      expect(group.description, isNull);
      expect(group.imageUrl, isNull);
    });

    test('copyWith updates specified fields', () {
      final original = Group(
        id: 'group-id',
        name: 'Original Name',
        description: 'Original Description',
        imageUrl: 'https://example.com/original.png',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025),
        isActive: true,
      );

      final copied = original.copyWith(
        name: 'New Name',
        description: 'New Description',
        isActive: false,
      );

      expect(copied.id, equals(original.id));
      expect(copied.name, equals('New Name'));
      expect(copied.description, equals('New Description'));
      expect(copied.imageUrl, equals(original.imageUrl));
      expect(copied.createdBy, equals(original.createdBy));
      expect(copied.createdAt, equals(original.createdAt));
      expect(copied.isActive, isFalse);
    });

    test('copyWith preserves all fields when none specified', () {
      final original = Group(
        id: 'group-id',
        name: 'Test Group',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.png',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025),
        updatedAt: DateTime.utc(2025, 1, 2),
        isActive: true,
      );

      final copied = original.copyWith();

      expect(copied.id, equals(original.id));
      expect(copied.name, equals(original.name));
      expect(copied.description, equals(original.description));
      expect(copied.imageUrl, equals(original.imageUrl));
      expect(copied.createdBy, equals(original.createdBy));
      expect(copied.createdAt, equals(original.createdAt));
      expect(copied.updatedAt, equals(original.updatedAt));
      expect(copied.isActive, equals(original.isActive));
    });

    test('copyWith can set updatedAt', () {
      final original = Group(
        id: 'group-id',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025),
        isActive: true,
      );

      final updatedAt = DateTime.utc(2025, 1, 15, 10, 30);
      final copied = original.copyWith(updatedAt: updatedAt);

      expect(copied.updatedAt, equals(updatedAt));
    });
  });
}
