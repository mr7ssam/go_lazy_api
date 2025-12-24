import 'package:common/common.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLocationsRepo extends Mock implements ILocationsRepo {}

void main() {
  late GetLocationsHandler handler;
  late MockLocationsRepo mockLocationsRepo;

  setUp(() {
    mockLocationsRepo = MockLocationsRepo();
    handler = GetLocationsHandler(
      locationsRepo: mockLocationsRepo,
    );
  });

  group('GetLocationsHandler', () {
    test('returns user locations successfully', () async {
      const request = GetLocationsRequest(
        userId: 'user-123',
      );

      final locations = [
        Location(
          id: 1,
          userId: 'user-123',
          name: 'Home',
          address: '123 Main St',
          latitude: 37.7749,
          longitude: -122.4194,
          isFavorite: true,
          createdAt: DateTime(2025),
          updatedAt: DateTime(2025),
        ),
        Location(
          id: 2,
          userId: 'user-123',
          name: 'Work',
          address: '456 Work Ave',
          latitude: 37.7849,
          longitude: -122.4294,
          isFavorite: false,
          createdAt: DateTime(2025, 1, 2),
          updatedAt: DateTime(2025, 1, 2),
        ),
      ];

      when(
        () => mockLocationsRepo.getUserLocations(
          userId: 'user-123',
        ),
      ).thenAnswer((_) async => locations);

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.locations, hasLength(2));
          expect(data.locations[0].name, equals('Home'));
          expect(data.locations[1].name, equals('Work'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns group locations successfully', () async {
      const request = GetLocationsRequest(
        groupId: 'group-456',
      );

      final locations = [
        Location(
          id: 3,
          groupId: 'group-456',
          name: 'Office',
          address: '789 Office Blvd',
          latitude: 37.7949,
          longitude: -122.4394,
          isFavorite: true,
          createdAt: DateTime(2025, 1, 3),
          updatedAt: DateTime(2025, 1, 3),
        ),
      ];

      when(
        () => mockLocationsRepo.getGroupLocations(
          groupId: 'group-456',
        ),
      ).thenAnswer((_) async => locations);

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.locations, hasLength(1));
          expect(data.locations[0].name, equals('Office'));
          expect(data.locations[0].groupId, equals('group-456'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('filters locations by category', () async {
      const request = GetLocationsRequest(
        userId: 'user-123',
        category: 'work',
      );

      final locations = [
        Location(
          id: 2,
          userId: 'user-123',
          name: 'Work',
          address: '456 Work Ave',
          latitude: 37.7849,
          longitude: -122.4294,
          category: 'work',
          isFavorite: false,
          createdAt: DateTime(2025, 1, 2),
          updatedAt: DateTime(2025, 1, 2),
        ),
      ];

      when(
        () => mockLocationsRepo.getUserLocations(
          userId: 'user-123',
          category: 'work',
        ),
      ).thenAnswer((_) async => locations);

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.locations, hasLength(1));
          expect(data.locations[0].category, equals('work'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('filters locations by favorites', () async {
      const request = GetLocationsRequest(
        userId: 'user-123',
        favoritesOnly: true,
      );

      final locations = [
        Location(
          id: 1,
          userId: 'user-123',
          name: 'Home',
          address: '123 Main St',
          latitude: 37.7749,
          longitude: -122.4194,
          isFavorite: true,
          createdAt: DateTime(2025),
          updatedAt: DateTime(2025),
        ),
      ];

      when(
        () => mockLocationsRepo.getUserLocations(
          userId: 'user-123',
          favoritesOnly: true,
        ),
      ).thenAnswer((_) async => locations);

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.locations, hasLength(1));
          expect(data.locations[0].isFavorite, isTrue);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns empty list when no locations found', () async {
      const request = GetLocationsRequest(
        userId: 'user-123',
      );

      when(
        () => mockLocationsRepo.getUserLocations(
          userId: 'user-123',
        ),
      ).thenAnswer((_) async => []);

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.locations, isEmpty);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns BadRequestError when both userId and groupId provided',
        () async {
      const request = GetLocationsRequest(
        userId: 'user-123',
        groupId: 'group-456',
      );

      final result = await handler.handle(request);

      result.when(
        success: (_) => fail('Expected error'),
        failed: (error) {
          expect(error, isA<BadRequestError>());
          expect(
            error.message,
            contains('Must specify either userId or groupId'),
          );
        },
      );
    });

    test('returns BadRequestError when neither userId nor groupId provided',
        () async {
      const request = GetLocationsRequest();

      final result = await handler.handle(request);

      result.when(
        success: (_) => fail('Expected error'),
        failed: (error) {
          expect(error, isA<BadRequestError>());
          expect(
            error.message,
            contains('Must specify either userId or groupId'),
          );
        },
      );
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      const request = GetLocationsRequest(
        userId: 'user-123',
      );

      when(
        () => mockLocationsRepo.getUserLocations(
          userId: any(named: 'userId'),
          category: any(named: 'category'),
          favoritesOnly: any(named: 'favoritesOnly'),
        ),
      ).thenThrow(Exception('Database error'));

      final result = await handler.handle(request);

      result.when(
        success: (_) => fail('Expected error'),
        failed: (error) {
          expect(error, isA<InternalServerError>());
        },
      );
    });
  });
}
