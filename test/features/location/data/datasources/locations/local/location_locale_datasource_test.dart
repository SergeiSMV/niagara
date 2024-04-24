import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/data/datasources/locations/local/location_drift_dao.dart';
import 'package:niagara_app/features/location/data/datasources/locations/local/location_locale_datasource.dart';
import 'package:niagara_app/features/location/data/mappers/model_to_companion_location_mapper.dart';
import 'package:niagara_app/features/location/data/models/location_model.dart';

import 'location_locale_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppDatabase>(),
  MockSpec<LocationsLocalDatasource>(),
  MockSpec<AllLocations>(),
])
void main() {
  late ILocationsLocalDatasource datasource;
  late MockAppDatabase mockDatabase;
  late MockAllLocations allLocations;

  const location = LocationModel(
    latitude: 37.7749,
    longitude: -122.4194,
    name: 'San Francisco',
    description: 'San Francisco, California, United States',
    precision: LocationPrecision.exact,
    province: 'California',
    city: 'San Francisco',
    locality: 'San Francisco',
    district: 'San Francisco',
    street: 'random street',
    house: 'random house',
    floor: 'random floor',
    flat: 'random flat',
    entrance: 'random entrance',
    isPrimary: true,
  );

  const locations = [
    location,

    // Los Angeles
    LocationModel(
      latitude: 34.0522,
      longitude: -118.2437,
      name: 'Los Angeles',
      description: 'Los Angeles, California, United States',
      precision: LocationPrecision.exact,
      province: 'California',
      city: 'Los Angeles',
      locality: 'Los Angeles',
      district: 'Los Angeles',
      street: 'random street',
      house: 'random house',
      floor: 'random floor',
      flat: 'random flat',
      entrance: 'random entrance',
    ),
  ];

  setUpAll(() {
    mockDatabase = MockAppDatabase();
    datasource = LocationsLocalDatasource(database: mockDatabase);
    allLocations = MockAllLocations();

    when(mockDatabase.allLocations).thenReturn(allLocations);
  });

  group('getLocations', () {
    test('should return a list of locations', () async {
      when(allLocations.getLocations()).thenAnswer((_) async => locations);

      final result = await datasource.getLocations();

      expect(result, isA<Right<Failure, List<LocationModel>>>());
      verify(allLocations.getLocations()).called(1);
    });

    test('should return a LocalDataFailure when an exception is thrown',
        () async {
      when(allLocations.getLocations()).thenThrow(Exception('Error'));

      final result = await datasource.getLocations();

      expect(result, isA<Left<Failure, List<LocationModel>>>());
      verify(allLocations.getLocations()).called(1);
    });
  });

  group('storeLocation', () {
    test('should store the location', () async {
      when(allLocations.insertLocation(location.toCompanion()))
          .thenAnswer((_) async => 1);

      final result = await datasource.addLocation(location);

      expect(result, const Right<Failure, void>(null));
      verify(allLocations.insertLocation(location.toCompanion())).called(1);
    });

    test('should return a LocalDataFailure when an exception is thrown',
        () async {
      when(allLocations.insertLocation(location.toCompanion()))
          .thenThrow(Exception('Error'));

      final result = await datasource.addLocation(location);

      expect(result, isA<Left<Failure, void>>());
      verify(allLocations.insertLocation(location.toCompanion())).called(1);
    });
  });

  group('getPrimaryLocation', () {
    test('should return the primary location', () async {
      when(allLocations.getPrimaryLocation()).thenAnswer((_) async => location);

      final result = await datasource.getPrimaryLocation();

      expect(result, isA<Right<Failure, LocationModel>>());
      verify(allLocations.getPrimaryLocation()).called(1);
    });

    test('should return a LocalDataFailure when an exception is thrown',
        () async {
      when(allLocations.getPrimaryLocation()).thenThrow(Exception('Error'));

      final result = await datasource.getPrimaryLocation();

      expect(result, isA<Left<Failure, LocationModel>>());
      verify(allLocations.getPrimaryLocation()).called(1);
    });
  });
}
