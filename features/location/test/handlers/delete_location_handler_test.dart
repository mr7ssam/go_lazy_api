import 'package:common/common.dart';
import 'package:location/location_domain.dart';
import 'package:location/location_handlers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLocationsRepo extends Mock implements ILocationsRepo {}

void main() {
  late DeleteLocationHandler handler;
  late MockLocationsRepo mockLocationsRepo;

  setUp(() {
    mockLocationsRepo = MockLocationsRepo();
    handler = DeleteLocationHandler(
      locationsRepo: mockLocationsRepo,
    );
  });

  group('DeleteLocationHandler', () {
    test('deletes user location successfully', () async {
      const request = DeleteLocationRequest(
        userId: 'user-123',
        locationId: 1,
      );

      when(
        () => mockLocationsRepo.deleteUserLocation(
          userId: 'user-123',
          locationId: 1,
        ),
      ).thenAnswer((_) async => {});

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.message, equals('Location deleted successfully'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(
        () => mockLocationsRepo.deleteUserLocation(
          userId: 'user-123',
          locationId: 1,
        ),
      ).called(1);
    });

    test('deletes group location successfully', () async {
      const request = DeleteLocationRequest(
        groupId: 'group-456',
        locationId: 2,
      );

      when(
        () => mockLocationsRepo.deleteGroupLocation(
          groupId: 'group-456',
          locationId: 2,
        ),
      ).thenAnswer((_) async => {});

      final result = await handler.handle(request);

      result.when(
        success: (data) {
          expect(data.message, equals('Location deleted successfully'));
        },
        failed: (error) =>
            fail('Expected success, got error: ${error.message}'),
      );

      verify(
        () => mockLocationsRepo.deleteGroupLocation(
          groupId: 'group-456',
          locationId: 2,
        ),
      ).called(1);
    });

    test('returns NotFoundError when location does not exist', () async {
      const request = DeleteLocationRequest(
        userId: 'user-123',
        locationId: 999,
      );

      when(
        () => mockLocationsRepo.deleteUserLocation(
          userId: 'user-123',
          locationId: 999,
        ),
      ).thenThrow(NotFoundError(message: 'Location not found'));

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
      const request = DeleteLocationRequest(
        userId: 'user-123',
        groupId: 'group-456',
        locationId: 1,
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
      const request = DeleteLocationRequest(
        locationId: 1,
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

    test('returns InternalServerError when repository throws exception',
        () async {
      const request = DeleteLocationRequest(
        userId: 'user-123',
        locationId: 1,
      );

      when(
        () => mockLocationsRepo.deleteUserLocation(
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

    test('returns NotFoundError when deleting non-existent user location',
        () async {
      const request = DeleteLocationRequest(
        userId: 'user-123',
        locationId: 999,
      );

      when(
        () => mockLocationsRepo.deleteUserLocation(
          userId: 'user-123',
          locationId: 999,
        ),
      ).thenThrow(NotFoundError(message: 'Location with ID 999 not found'));

      final result = await handler.handle(request);

      result.when(
        success: (_) => fail('Expected error'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.message, contains('999'));
        },
      );
    });

    test('returns NotFoundError when deleting non-existent group location',
        () async {
      const request = DeleteLocationRequest(
        groupId: 'group-456',
        locationId: 888,
      );

      when(
        () => mockLocationsRepo.deleteGroupLocation(
          groupId: 'group-456',
          locationId: 888,
        ),
      ).thenThrow(NotFoundError(message: 'Location with ID 888 not found'));

      final result = await handler.handle(request);

      result.when(
        success: (_) => fail('Expected error'),
        failed: (error) {
          expect(error, isA<NotFoundError>());
          expect(error.message, contains('888'));
        },
      );
    });
  });
}
