import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/features/location/data/datasources/cities/remote/cities_remote_datasource.dart';
import 'package:niagara_app/features/location/data/models/city_model.dart';

import 'cities_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RequestHandler>(),
  MockSpec<CitiesRemoteDatasource>(),
])
void main() {
  late MockRequestHandler mockRequestHandler;
  late ICitiesRemoteDatasource dataSource;

  setUp(() {
    mockRequestHandler = MockRequestHandler();
    dataSource = CitiesRemoteDatasource(requestHandler: mockRequestHandler);
  });

  group('getCities', () {
    const cities = [
      CityModel(
        city: 'Уфа',
        region: 'Башкортостан республика',
        lat: 54.735147,
        lon: 55.958727,
      ),
      CityModel(
        city: 'Краснодар',
        region: 'Краснодарский край',
        lat: 45.03547,
        lon: 38.975313,
      ),
      CityModel(
        city: 'Курган',
        region: 'Курганская область',
        lat: 55.441004,
        lon: 65.341118,
      ),
    ];

    provideDummy<Either<Failure, List<CityModel>>>(const Right(cities));
    provideDummy<Either<Failure, List<dynamic>>>(
      const Left(CitiesDataFailure()),
    );

    test('should return a list of cities when successful', () async {
      // Arrange
      when(
        mockRequestHandler.sendRequest<List<CityModel>, List<dynamic>>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).thenAnswer((_) async => const Right(cities));

      // Act
      final result = await dataSource.getCities();

      // Assert
      expect(result, isA<Right<Failure, List<CityModel>>>());
      verify(
        mockRequestHandler.sendRequest<List<CityModel>, List<dynamic>>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).called(1);
    });

    test('should return a failure when unsuccessful', () async {
      // Arrange
      const failure = CitiesDataFailure('Error');
      when(
        mockRequestHandler.sendRequest<List<CityModel>, List<dynamic>>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await dataSource.getCities();

      // Assert
      expect(result, isA<Left<Failure, List<CityModel>>>());
      verify(
        mockRequestHandler.sendRequest<List<CityModel>, List<dynamic>>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).called(1);
    });
  });
}
