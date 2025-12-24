import 'package:common/common.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

class MockLocationsRepo extends Mock implements ILocationsRepo {}

class FakeLocation extends Fake implements Location {}

class _FakeUniqueViolationException extends Fake
    implements UniqueViolationException {}

void main() {
  late UpdateLocationHandler handler;
  late MockLocationsRepo mockLocationsRepo;
  late LocalizationService localization;

  setUpAll(() {
    registerFallbackValue(FakeLocation());
  });

  setUp(() {
    mockLocationsRepo = MockLocationsRepo();
    localization = LocalizationService();
    handler = UpdateLocationHandler(
      locationsRepo: mockLocationsRepo,
      localization: localization,
    );
  });

  group('UpdateLocationHandler', () {
    test('updates user location successfully', () async {
      const request = UpdateLocationRequest(
        userId: 'user-123',
        locationId: 1,
        name: 'Updated Home',
        address: '123 New St',
        latitude: 37.7849,
        longitude: -122.4294,
        isFavorite: true,
      );

      final existing = Location(
        id: 1,
        userId: 'user-123',
        name: 'Home',
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
        isFavorite: false,
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
      );

      when(
        () => mockLocationsRepo.getUserLocationById(
          userId: 'user-123',
          locationId: 1,
        ),
      ).thenAnswer((_) async => existing);

      when(
        () => mockLocationsRepo.updateUserLocation(any()),
      ).thenAnswer((_) async => {});

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.location.id, equals(1));
          expect(data.location.name, equals('Updated Home'));
          expect(data.location.address, equals('123 New St'));
          expect(data.location.latitude, equals(37.7849));
          expect(data.location.isFavorite, isTrue);
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => mockLocationsRepo.updateUserLocation(any())).called(1);
    });

    test('updates group location successfully', () async {
      const request = UpdateLocationRequest(
        groupId: 'group-456',
        locationId: 2,
        name: 'Updated Office',
        address: '456 New Ave',
        latitude: 37.7949,
        longitude: -122.4394,
        category: 'work',
        isFavorite: false,
      );

      final existing = Location(
        id: 2,
        groupId: 'group-456',
        name: 'Office',
        address: '456 Work Ave',
        latitude: 37.7849,
        longitude: -122.4294,
        isFavorite: false,
        createdAt: DateTime(2025, 1, 2),
        updatedAt: DateTime(2025, 1, 2),
      );

      when(
        () => mockLocationsRepo.getGroupLocationById(
          groupId: 'group-456',
          locationId: 2,
        ),
      ).thenAnswer((_) async => existing);

      when(
        () => mockLocationsRepo.updateGroupLocation(any()),
      ).thenAnswer((_) async => {});

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.location.id, equals(2));
          expect(data.location.name, equals('Updated Office'));
          expect(data.location.category, equals('work'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(() => mockLocationsRepo.updateGroupLocation(any())).called(1);
    });

    test('returns NotFoundError when location does not exist', () async {
      const request = UpdateLocationRequest(
        userId: 'user-123',
        locationId: 999,
        name: 'Test',
        address: 'Test',
        latitude: 0,
        longitude: 0,
        isFavorite: false,
      );

      when(
        () => mockLocationsRepo.getUserLocationById(
          userId: 'user-123',
          locationId: 999,
        ),
      ).thenAnswer((_) async => null);

      final result = await handler.handle(request);

      result.when(
        success: (_) => fail('Expected error'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.message, contains('not found'));
        },
      );
    });

    test('returns BadRequestError when both userId and groupId provided',
        () async {
      const request = UpdateLocationRequest(
        userId: 'user-123',
        groupId: 'group-456',
        locationId: 1,
        name: 'Test',
        address: 'Test',
        latitude: 0,
        longitude: 0,
        isFavorite: false,
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
      const request = UpdateLocationRequest(
        locationId: 1,
        name: 'Test',
        address: 'Test',
        latitude: 0,
        longitude: 0,
        isFavorite: false,
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

    test('returns ConflictError when updated name conflicts', () async {
      const request = UpdateLocationRequest(
        userId: 'user-123',
        locationId: 1,
        name: 'Duplicate Name',
        address: 'Test',
        latitude: 0,
        longitude: 0,
        isFavorite: false,
      );

      final existing = Location(
        id: 1,
        userId: 'user-123',
        name: 'Home',
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
        isFavorite: false,
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
      );

      when(
        () => mockLocationsRepo.getUserLocationById(
          userId: 'user-123',
          locationId: 1,
        ),
      ).thenAnswer((_) async => existing);

      final exception = _FakeUniqueViolationException();

      when(
        () => mockLocationsRepo.updateUserLocation(any()),
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
      const request = UpdateLocationRequest(
        userId: 'user-123',
        locationId: 1,
        name: 'Test',
        address: 'Test',
        latitude: 0,
        longitude: 0,
        isFavorite: false,
      );

      when(
        () => mockLocationsRepo.getUserLocationById(
          userId: any(named: 'userId'),
          locationId: any(named: 'locationId'),
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
