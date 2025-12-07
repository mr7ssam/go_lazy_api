import 'package:group/group_handlers.dart';
import 'package:test/test.dart';

void main() {
  group('GetUserGroupsRequest', () {
    test('fromJson parses userId correctly', () {
      final json = {
        'userId': 'user-123',
      };

      final request = GetUserGroupsRequest.fromJson(json);

      expect(request.userId, equals('user-123'));
    });
  });

  group('GroupSummary', () {
    test('toJson serializes all fields correctly', () {
      final summary = GroupSummary(
        id: 'group-123',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        description: 'A test description',
        imageUrl: 'https://example.com/image.png',
        updatedAt: DateTime.utc(2025, 1, 2, 15, 30),
      );

      final json = summary.toJson();

      expect(json['id'], equals('group-123'));
      expect(json['name'], equals('Test Group'));
      expect(json['createdBy'], equals('user-123'));
      expect(json['createdAt'], equals('2025-01-01T12:00:00.000Z'));
      expect(json['description'], equals('A test description'));
      expect(json['imageUrl'], equals('https://example.com/image.png'));
      expect(json['updatedAt'], equals('2025-01-02T15:30:00.000Z'));
    });

    test('toJson handles null optional fields', () {
      final summary = GroupSummary(
        id: 'group-123',
        name: 'Test Group',
        createdBy: 'user-123',
        createdAt: DateTime.utc(2025, 1, 1, 12),
      );

      final json = summary.toJson();

      expect(json['description'], isNull);
      expect(json['imageUrl'], isNull);
      expect(json['updatedAt'], isNull);
    });
  });

  group('GetUserGroupsResponse', () {
    test('toJson serializes groups list correctly', () {
      final response = GetUserGroupsResponse(
        groups: [
          GroupSummary(
            id: 'group-1',
            name: 'Group One',
            createdBy: 'user-123',
            createdAt: DateTime.utc(2025),
          ),
          GroupSummary(
            id: 'group-2',
            name: 'Group Two',
            createdBy: 'user-456',
            createdAt: DateTime.utc(2025, 1, 2),
            description: 'Second group',
          ),
        ],
      );

      final json = response.toJson();

      expect(json['groups'], isA<List<Map<String, dynamic>>>());
      final groups = json['groups'] as List<Map<String, dynamic>>;
      expect(groups, hasLength(2));
      expect(groups[0]['id'], equals('group-1'));
      expect(groups[0]['name'], equals('Group One'));
      expect(groups[1]['id'], equals('group-2'));
      expect(groups[1]['description'], equals('Second group'));
    });

    test('toJson handles empty groups list', () {
      const response = GetUserGroupsResponse(groups: []);

      final json = response.toJson();

      expect(json['groups'], isEmpty);
    });
  });
}
