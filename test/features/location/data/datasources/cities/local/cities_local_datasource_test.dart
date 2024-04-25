import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/features/location/data/cities/local/dao/cities_dao.dart';
import 'package:niagara_app/features/location/data/cities/local/data_source/cities_local_data_source.dart';
import 'package:niagara_app/features/location/data/cities/local/entities/city_entity.dart';
import 'package:niagara_app/features/location/data/cities/mappers/city_entity_mapper.dart';

import 'cities_local_datasource_test.mocks.dart';

@GenerateMocks([
  AppDatabase,
  CitiesLocalDatasource,
  AllCities,
])
void main() {
  late MockAppDatabase mockDatabase;
  late ICitiesLocalDatasource datasource;
  late MockAllCities allCities;

  const city = CitiesTableData(
    id: 1,
    latitude: 37.7749,
    longitude: -122.4194,
    province: 'California',
    locality: 'San Francisco',
  );

  setUpAll(() {
    mockDatabase = MockAppDatabase();
    datasource = CitiesLocalDatasource(database: mockDatabase);
    allCities = MockAllCities();
    when(mockDatabase.allCities).thenReturn(allCities);
  });

  group('getCity', () {
    test('should return a CityModel when data is available', () async {
      // Arrange
      when(allCities.getCities()).thenAnswer((_) async => [city]);

      // Act
      final result = await datasource.getCity();

      // Assert
      expect(result, isA<Right<Failure, CityEntity>>());
      verify(allCities.getCities()).called(1);
    });

    test('should return a CitiesLocalDataFailure when no data is available',
        () async {
      // Arrange
      when(allCities.getCities()).thenAnswer((_) async => []);

      // Act
      final result = await datasource.getCity();

      // Assert
      expect(result, isA<Left<Failure, CityEntity>>());
      verify(allCities.getCities()).called(1);
    });
  });

  group('setCity', () {
    test('should clear and insert the provided CityModel', () async {
      // Arrange
      when(allCities.clearCities()).thenAnswer((_) async {});
      when(allCities.insertCity(city.toCompanion(false)))
          .thenAnswer((_) async => 1);

      // Act
      final result = await datasource.setCity(city.toEntity());

      // Assert
      expect(result, const Right<Failure, void>(null));
      verify(allCities.clearCities()).called(1);
      verify(allCities.insertCity(city.toCompanion(false))).called(1);
    });
  });
}
