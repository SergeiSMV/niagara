import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/locations/addresses/data/local/dao/addresses_dao.dart';
import 'package:niagara_app/features/locations/addresses/data/local/data_source/addresses_local_data_source.dart';
import 'package:niagara_app/features/locations/addresses/data/local/entities/addresses_entity.dart';
import 'package:niagara_app/features/locations/addresses/data/mappers/address_entity_mapper.dart';

import 'location_locale_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppDatabase>(),
  MockSpec<AddressesLocalDatasource>(),
  MockSpec<AllAddresses>(),
])
void main() {
  late IAddressesLocalDatasource datasource;
  late MockAppDatabase mockDatabase;
  late MockAllAddresses allAddresses;

  const location = AddressesTableData(
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
    AddressesTableData(
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
    datasource = AddressesLocalDatasource(mockDatabase);
    allAddresses = MockAllAddresses();

    when(mockDatabase.allAddresses).thenReturn(allAddresses);
  });

  group('getLocations', () {
    test('should return a list of locations', () async {
      when(allAddresses.getAddresses()).thenAnswer((_) async => locations);

      final result = await datasource.getAddresses();

      expect(result, isA<Right<Failure, List<AddressEntity>>>());
      verify(allAddresses.getAddresses()).called(1);
    });

    test('should return a LocalDataFailure when an exception is thrown',
        () async {
      when(allAddresses.getAddresses()).thenThrow(Exception('Error'));

      final result = await datasource.getAddresses();

      expect(result, isA<Left<Failure, List<AddressEntity>>>());
      verify(allAddresses.getAddresses()).called(1);
    });
  });

  group('storeLocation', () {
    test('should store the location', () async {
      when(allAddresses.insertAddress(location.toCompanion(false)))
          .thenAnswer((_) async => 1);

      final result = await datasource.addAddress(location.toEntity());

      expect(result, const Right<Failure, void>(null));
      verify(allAddresses.insertAddress(location.toCompanion(false))).called(1);
    });

    test('should return a LocalDataFailure when an exception is thrown',
        () async {
      when(allAddresses.insertAddress(location.toCompanion(false)))
          .thenThrow(Exception('Error'));

      final result = await datasource.addAddress(location.toEntity());

      expect(result, isA<Left<Failure, void>>());
      verify(allAddresses.insertAddress(location.toCompanion(false))).called(1);
    });
  });
}
