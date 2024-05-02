import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/data/locations/local/dao/location_dao.dart';
import 'package:niagara_app/features/location/data/locations/local/data_source/location_locale_data_source.dart';
import 'package:niagara_app/features/location/data/locations/local/entities/location_entity.dart';
import 'package:niagara_app/features/location/data/locations/mappers/location_entity_mapper.dart';

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

  const location = LocationsTableData(
    id: 1,
    latitude: 37.7749,
    longitude: -122.4194,
    name: 'San Francisco',
    description: 'San Francisco, California, United States',
    precision: LocationPrecision.exact,
    province: 'California',
    locality: 'San Francisco',
    district: 'San Francisco',
    street: 'random street',
    house: 'random house',
    floor: 'random floor',
    flat: 'random flat',
    entrance: 'random entrance',
    isDefault: true,
    locationId: 'random location id',
  );

  const locations = [
    location,

    // Los Angeles
    LocationsTableData(
      id: 2,
      latitude: 34.0522,
      longitude: -118.2437,
      name: 'Los Angeles',
      description: 'Los Angeles, California, United States',
      precision: LocationPrecision.exact,
      province: 'California',
      locality: 'Los Angeles',
      district: 'Los Angeles',
      street: 'random street',
      house: 'random house',
      floor: 'random floor',
      flat: 'random flat',
      entrance: 'random entrance',
      isDefault: false,
      locationId: 'random location id',
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

      expect(result, isA<Right<Failure, List<LocationEntity>>>());
      verify(allLocations.getLocations()).called(1);
    });

    test('should return a LocalDataFailure when an exception is thrown',
        () async {
      when(allLocations.getLocations()).thenThrow(Exception('Error'));

      final result = await datasource.getLocations();

      expect(result, isA<Left<Failure, List<LocationEntity>>>());
      verify(allLocations.getLocations()).called(1);
    });
  });

  group('storeLocation', () {
    test('should store the location', () async {
      when(allLocations.insertLocation(location.toCompanion(false)))
          .thenAnswer((_) async => 1);

      final result = await datasource.addLocation(location.toEntity());

      expect(result, const Right<Failure, void>(null));
      verify(allLocations.insertLocation(location.toCompanion(false)))
          .called(1);
    });

    test('should return a LocalDataFailure when an exception is thrown',
        () async {
      when(allLocations.insertLocation(location.toCompanion(false)))
          .thenThrow(Exception('Error'));

      final result = await datasource.addLocation(location.toEntity());

      expect(result, isA<Left<Failure, void>>());
      verify(allLocations.insertLocation(location.toCompanion(false)))
          .called(1);
    });
  });
}
