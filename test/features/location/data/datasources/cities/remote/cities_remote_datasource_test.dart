import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/features/location/data/cities/remote/data_source/cities_remote_data_source.dart';
import 'package:niagara_app/features/location/data/cities/remote/dto/city_dto.dart';

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
      CityDto(
        id: 1,
        city: 'Уфа',
        region: 'Башкортостан республика',
        latitude: 54.735147,
        longitude: 55.958727,
        phone: '+7 347 123-45-67',
      ),
      CityDto(
        id: 2,
        city: 'Краснодар',
        region: 'Краснодарский край',
        latitude: 45.03547,
        longitude: 38.975313,
        phone: '+7 861 123-45-67',
      ),
      CityDto(
        id: 3,
        city: 'Курган',
        region: 'Курганская область',
        latitude: 55.441004,
        longitude: 65.341118,
        phone: '+7 352 123-45-67', 
      ),
    ];

    provideDummy<Either<Failure, List<CityDto>>>(const Right(cities));
    provideDummy<Either<Failure, List<dynamic>>>(
      const Left(CitiesRemoteDataFailure()),
    );

    test('should return a list of cities when successful', () async {
      // Arrange
      when(
        mockRequestHandler.sendRequest<List<CityDto>, List<dynamic>>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).thenAnswer((_) async => const Right(cities));

      // Act
      final result = await dataSource.getCities();

      // Assert
      expect(result, isA<Right<Failure, List<CityDto>>>());
      verify(
        mockRequestHandler.sendRequest<List<CityDto>, List<dynamic>>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).called(1);
    });

    test('should return a failure when unsuccessful', () async {
      // Arrange
      const failure = CitiesRemoteDataFailure('Error');
      when(
        mockRequestHandler.sendRequest<List<CityDto>, List<dynamic>>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await dataSource.getCities();

      // Assert
      expect(result, isA<Left<Failure, List<CityDto>>>());
      verify(
        mockRequestHandler.sendRequest<List<CityDto>, List<dynamic>>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).called(1);
    });
  });
}
