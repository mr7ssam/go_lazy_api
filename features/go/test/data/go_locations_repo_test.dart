import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:go/go_data.dart';
import 'package:go/go_domain.dart';
import 'package:test/test.dart';

void main() {
  late GoLocationsRepoTestContext context;

  setUp(() async {
    context = await GoLocationsRepoTestContext.create();
  });

  tearDown(() async {
    await context.dispose();
  });

  group('GoLocationsRepo - Location CRUD', () {
    test('createLocation inserts location and returns domain model', () async {
      final location = GoLocation.create(
        name: 'Central Park',
        createdBy: 'user-123',
        address: '123 Park Ave, NY',
        latitude: 40.7829,
        longitude: -73.9654,
      );

      final created = await context.goLocationsRepo.createLocation(location);

      expect(created.id, location.id);
      expect(created.name, 'Central Park');
      expect(created.createdBy, 'user-123');
      expect(created.address, '123 Park Ave, NY');
      expect(created.latitude, 40.7829);
      expect(created.longitude, -73.9654);
      expect(created.isActive, true);

      final stored = await context.goLocationsRepo.getLocationById(location.id);
      expect(stored, isNotNull);
      expect(stored!.name, 'Central Park');
    });

    test('getLocationById returns stored location when found', () async {
      final location = GoLocation.create(
        name: 'Beach Resort',
        createdBy: 'user-456',
        googleMapsUrl: 'https://maps.google.com/beach',
      );
      await context.goLocationsRepo.createLocation(location);

      final result = await context.goLocationsRepo.getLocationById(location.id);

      expect(result, isNotNull);
      expect(result!.id, location.id);
      expect(result.name, 'Beach Resort');
      expect(result.googleMapsUrl, 'https://maps.google.com/beach');
    });

    test('getLocationById returns null when location does not exist', () async {
      final result =
          await context.goLocationsRepo.getLocationById('missing-id');

      expect(result, isNull);
    });

    test('updateLocation modifies existing location', () async {
      final location = GoLocation.create(
        name: 'Old Name',
        createdBy: 'user-123',
      );
      await context.goLocationsRepo.createLocation(location);

      final updated = location.copyWith(
        name: 'Updated Name',
        address: '456 New Street',
      );
      await context.goLocationsRepo.updateLocation(updated);

      final stored = await context.goLocationsRepo.getLocationById(location.id);
      expect(stored, isNotNull);
      expect(stored!.name, 'Updated Name');
      expect(stored.address, '456 New Street');
    });

    test('deleteLocation soft-deletes location', () async {
      final location = GoLocation.create(
        name: 'To Be Deleted',
        createdBy: 'user-789',
      );
      await context.goLocationsRepo.createLocation(location);

      await context.goLocationsRepo.deleteLocation(location.id);

      final result = await context.goLocationsRepo.getLocationById(location.id);
      expect(result, isNull);
    });
  });

  group('GoLocationsRepo - Queries', () {
    test('getUserLocations returns locations for specific user', () async {
      final location1 = GoLocation.create(
        name: 'User A Location 1',
        createdBy: 'user-a',
      );
      final location2 = GoLocation.create(
        name: 'User A Location 2',
        createdBy: 'user-a',
      );
      final location3 = GoLocation.create(
        name: 'User B Location',
        createdBy: 'user-b',
      );

      await context.goLocationsRepo.createLocation(location1);
      await context.goLocationsRepo.createLocation(location2);
      await context.goLocationsRepo.createLocation(location3);

      final result = await context.goLocationsRepo.getUserLocations('user-a');

      expect(result, hasLength(2));
      expect(result.every((l) => l.createdBy == 'user-a'), isTrue);
      expect(
        result.map((l) => l.name),
        containsAll(['User A Location 1', 'User A Location 2']),
      );
    });

    test('getUserLocations excludes deleted locations', () async {
      final location1 = GoLocation.create(
        name: 'Active Location',
        createdBy: 'user-a',
      );
      final location2 = GoLocation.create(
        name: 'Deleted Location',
        createdBy: 'user-a',
      );

      await context.goLocationsRepo.createLocation(location1);
      await context.goLocationsRepo.createLocation(location2);

      await context.goLocationsRepo.deleteLocation(location2.id);

      final result = await context.goLocationsRepo.getUserLocations('user-a');

      expect(result, hasLength(1));
      expect(result.first.name, 'Active Location');
    });
  });

  group('GoLocationsRepo - Optional Fields', () {
    test('location can be created with minimal fields', () async {
      final location = GoLocation.create(
        name: 'Simple Location',
        createdBy: 'user-123',
      );

      await context.goLocationsRepo.createLocation(location);

      final stored = await context.goLocationsRepo.getLocationById(location.id);
      expect(stored, isNotNull);
      expect(stored!.name, 'Simple Location');
      expect(stored.address, isNull);
      expect(stored.latitude, isNull);
      expect(stored.longitude, isNull);
      expect(stored.googleMapsUrl, isNull);
    });

    test('location can include all optional fields', () async {
      final location = GoLocation.create(
        name: 'Complete Location',
        createdBy: 'user-123',
        address: '789 Complete St',
        latitude: 51.5074,
        longitude: -0.1278,
        googleMapsUrl: 'https://maps.google.com/complete',
      );

      await context.goLocationsRepo.createLocation(location);

      final stored = await context.goLocationsRepo.getLocationById(location.id);
      expect(stored, isNotNull);
      expect(stored!.address, '789 Complete St');
      expect(stored.latitude, 51.5074);
      expect(stored.longitude, -0.1278);
      expect(stored.googleMapsUrl, 'https://maps.google.com/complete');
    });

    test('location coordinates can be updated', () async {
      final location = GoLocation.create(
        name: 'Location with Coords',
        createdBy: 'user-123',
        latitude: 10,
        longitude: 20,
      );
      await context.goLocationsRepo.createLocation(location);

      final updated = location.copyWith(
        latitude: 15,
        longitude: 25,
      );
      await context.goLocationsRepo.updateLocation(updated);

      final stored = await context.goLocationsRepo.getLocationById(location.id);
      expect(stored!.latitude, 15);
      expect(stored.longitude, 25);
    });
  });
}

class GoLocationsRepoTestContext {
  GoLocationsRepoTestContext._({
    required this.database,
    required this.goLocationsRepo,
  });

  final Database database;
  final GoLocationsRepo goLocationsRepo;

  static Future<GoLocationsRepoTestContext> create() async {
    final database = Database(NativeDatabase.memory());
    await database.customStatement('PRAGMA foreign_keys = OFF');
    final goDao = GoDao(database);

    final goLocationsRepo = GoLocationsRepo(goDao: goDao);

    return GoLocationsRepoTestContext._(
      database: database,
      goLocationsRepo: goLocationsRepo,
    );
  }

  Future<void> dispose() async {
    await database.close();
  }
}
