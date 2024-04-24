import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/features/location/data/datasources/cities/local/cities_dao.dart';
import 'package:niagara_app/features/location/data/datasources/cities/local/cities_local_datasource.dart';
import 'package:niagara_app/features/location/data/mappers/city_companion_mapper.dart';
import 'package:niagara_app/features/location/data/models/city_model.dart';

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

  const city = CityModel(
    lat: 37.7749,
    lon: -122.4194,
    region: 'California',
    city: 'San Francisco',
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
      expect(result, isA<Right<Failure, CityModel>>());
      verify(allCities.getCities()).called(1);
    });

    test('should return a CitiesLocalDataFailure when no data is available',
        () async {
      // Arrange
      when(allCities.getCities()).thenAnswer((_) async => []);

      // Act
      final result = await datasource.getCity();

      // Assert
      expect(result, isA<Left<Failure, CityModel>>());
      verify(allCities.getCities()).called(1);
    });
  });

  group('setCity', () {
    test('should clear and insert the provided CityModel', () async {
      // Arrange
      when(allCities.clearCities()).thenAnswer((_) async {});
      when(allCities.insertCity(city.toCompanion())).thenAnswer((_) async => 1);

      // Act
      final result = await datasource.setCity(city);

      // Assert
      expect(result, const Right<Failure, void>(null));
      verify(allCities.clearCities()).called(1);
      verify(allCities.insertCity(city.toCompanion())).called(1);
    });
  });
}
