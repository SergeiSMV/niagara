import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/core/dependencies/di.dart';

import 'token_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ITokenRemoteDataSource>(),
  MockSpec<ITokenLocalDataSource>(),
  MockSpec<IDeviceIdDatasource>(),
  MockSpec<IAppLogger>(),
])
void main() {
  late TokenRepository tokenRepository;
  late MockITokenRemoteDataSource mockTokenRemoteDataSource;
  late MockITokenLocalDataSource mockTokenLocalDataSource;
  late MockIDeviceIdDatasource mockDeviceIdDatasource;
  late IAppLogger mockLogger;

  provideDummy<Either<Failure, void>>(const Right(null));
  provideDummy<Either<Failure, void>>(const Left(CreateTokenFailure()));

  provideDummy<Either<Failure, String>>(const Right('cached_token'));
  provideDummy<Either<Failure, String>>(const Left(GetTokenFailure()));

  setUpAll(() {
    getIt.registerSingleton<IAppLogger>(MockIAppLogger());
    mockTokenRemoteDataSource = MockITokenRemoteDataSource();
    mockTokenLocalDataSource = MockITokenLocalDataSource();
    mockDeviceIdDatasource = MockIDeviceIdDatasource();
    mockLogger = getIt.get<IAppLogger>();
    tokenRepository = TokenRepository(
      remoteDataSource: mockTokenRemoteDataSource,
      localDataSource: mockTokenLocalDataSource,
      deviceIdProvider: mockDeviceIdDatasource,
      logger: mockLogger,
    );
  });

  group('TokenRepository', () {
    test('getToken returns cached token if available', () async {
      when(mockTokenLocalDataSource.getToken())
          .thenAnswer((_) async => 'cached_token');

      final result = await tokenRepository.getToken();

      expect(result, const Right<Failure, String>('cached_token'));
      verifyNever(mockDeviceIdDatasource.getOrCreateUniqueId());
      verifyNever(
          mockTokenRemoteDataSource.getToken(deviceId: anyNamed('deviceId')));
      verifyNever(mockTokenLocalDataSource.setToken(token: anyNamed('token')));
    });

    test('getToken throws TokenNotFoundFailure if local token is null or empty',
        () async {
      when(mockTokenLocalDataSource.getToken()).thenAnswer((_) async => null);

      final result = await tokenRepository.getToken();

      expect(result, const Left<Failure, String>(GetTokenFailure()));
      verifyNever(mockDeviceIdDatasource.getOrCreateUniqueId());
      verifyNever(
          mockTokenRemoteDataSource.getToken(deviceId: anyNamed('deviceId')));
      verifyNever(mockTokenLocalDataSource.setToken(token: anyNamed('token')));
    });

    test('createToken throws DeviceIdFailure if device id fails', () async {
      when(mockDeviceIdDatasource.getOrCreateUniqueId())
          .thenAnswer((_) async => const Left(DeviceIdFailure()));

      final result = await tokenRepository.createToken();

      expect(result, const Left<Failure, void>(CreateTokenFailure()));
      verify(mockDeviceIdDatasource.getOrCreateUniqueId()).called(1);
      verifyNever(
          mockTokenRemoteDataSource.getToken(deviceId: anyNamed('deviceId')));
      verifyNever(mockTokenLocalDataSource.setToken(token: anyNamed('token')));
    });

    test('createToken throws GetTokenFailure if remote token fetch fails',
        () async {
      when(mockDeviceIdDatasource.getOrCreateUniqueId())
          .thenAnswer((_) async => const Right('test_device_id'));

      when(mockTokenRemoteDataSource.getToken(deviceId: 'test_device_id'))
          .thenAnswer((_) async => const Left(CreateTokenFailure()));

      final result = await tokenRepository.createToken();

      expect(result, const Left<Failure, void>(CreateTokenFailure()));
      verify(mockDeviceIdDatasource.getOrCreateUniqueId()).called(1);
      verify(mockTokenRemoteDataSource.getToken(deviceId: 'test_device_id'))
          .called(1);
      verifyNever(mockTokenLocalDataSource.setToken(token: anyNamed('token')));
    });
  });
}
