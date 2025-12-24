import 'package:common/common.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

class MockLocationsRepo extends Mock implements ILocationsRepo {}

class _FakeUniqueViolationException extends Fake
    implements UniqueViolationException {}

void main() {
  late CreateLocationHandler handler;
  late MockLocationsRepo mockLocationsRepo;
  late LocalizationService localization;

  setUp(() {
    mockLocationsRepo = MockLocationsRepo();
    localization = LocalizationService();
    handler = CreateLocationHandler(
      locationsRepo: mockLocationsRepo,
      localization: localization,
    );
  });

  group('CreateLocationHandler', () {
    test('creates user location successfully', () async {
      const request = CreateLocationRequest(
        userId: 'user-123',
        name: 'Home',
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
        category: 'home',
        isFavorite: true,
        notes: 'My home address',
      );

      final location = Location(
        id: 1,
        userId: 'user-123',
        name: 'Home',
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
        category: 'home',
        isFavorite: true,
        notes: 'My home address',
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
      );

      when(
        () => mockLocationsRepo.createUserLocation(
          userId: 'user-123',
          name: 'Home',
          address: '123 Main St',
          latitude: 37.7749,
          longitude: -122.4194,
          category: 'home',
          isFavorite: true,
          notes: 'My home address',
        ),
      ).thenAnswer((_) async => location);

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.location.id, equals(1));
          expect(data.location.userId, equals('user-123'));
          expect(data.location.name, equals('Home'));
          expect(data.location.latitude, equals(37.7749));
          expect(data.location.longitude, equals(-122.4194));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('creates group location successfully', () async {
      const request = CreateLocationRequest(
        groupId: 'group-456',
        name: 'Office',
        address: '456 Work Ave',
        latitude: 37.7849,
        longitude: -122.4294,
        category: 'work',
      );

      final location = Location(
        id: 2,
        groupId: 'group-456',
        name: 'Office',
        address: '456 Work Ave',
        latitude: 37.7849,
        longitude: -122.4294,
        category: 'work',
        isFavorite: false,
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
      );

      when(
        () => mockLocationsRepo.createGroupLocation(
          groupId: 'group-456',
          name: 'Office',
          address: '456 Work Ave',
          latitude: 37.7849,
          longitude: -122.4294,
          category: 'work',
        ),
      ).thenAnswer((_) async => location);

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.location.id, equals(2));
          expect(data.location.groupId, equals('group-456'));
          expect(data.location.name, equals('Office'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );
    });

    test('returns BadRequestError when both userId and groupId are provided',
        () async {
      const request = CreateLocationRequest(
        userId: 'user-123',
        groupId: 'group-456',
        name: 'Invalid',
        address: 'Invalid',
        latitude: 0,
        longitude: 0,
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
      const request = CreateLocationRequest(
        name: 'Invalid',
        address: 'Invalid',
        latitude: 0,
        longitude: 0,
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

    test('returns ConflictError when duplicate location name exists', () async {
      const request = CreateLocationRequest(
        userId: 'user-123',
        name: 'Duplicate',
        address: '789 Duplicate St',
        latitude: 37.7949,
        longitude: -122.4394,
      );

      final exception = _FakeUniqueViolationException();

      when(
        () => mockLocationsRepo.createUserLocation(
          userId: 'user-123',
          name: 'Duplicate',
          address: '789 Duplicate St',
          latitude: 37.7949,
          longitude: -122.4394,
        ),
      ).thenThrow(exception);

      final result = await handler.handle(request);

      result.when(
        success: (_) => fail('Expected error'),
        failed: (error) {
          expect(error, isA<ConflictError>());
          expect(error.message, isNotEmpty);
        },
      );
    });

    test('returns InternalServerError when repository throws exception',
        () async {
      const request = CreateLocationRequest(
        userId: 'user-123',
        name: 'Test',
        address: 'Test Address',
        latitude: 0,
        longitude: 0,
      );

      when(
        () => mockLocationsRepo.createUserLocation(
          userId: any(named: 'userId'),
          name: any(named: 'name'),
          address: any(named: 'address'),
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          category: any(named: 'category'),
          isFavorite: any(named: 'isFavorite'),
          notes: any(named: 'notes'),
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
