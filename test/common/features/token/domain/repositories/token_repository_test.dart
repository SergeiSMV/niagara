import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart';
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

  provideDummy<Either<Failure, String>>(const Right('test_token'));

  provideDummy<Either<Failure, bool>>(const Right(true));

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
    test('getToken gets device id, fetches token, and saves it', () async {
      when(mockDeviceIdDatasource.getOrCreateUniqueId())
          .thenAnswer((_) async => const Right('test_device_id'));

      when(mockTokenRemoteDataSource.getToken(deviceId: 'test_device_id'))
          .thenAnswer((_) async => const Right('test_token'));

      when(mockTokenLocalDataSource.setToken(token: 'test_token'))
          .thenAnswer((_) async => const Right<Failure, dynamic>(null));

      final result = await tokenRepository.createToken();

      verify(mockDeviceIdDatasource.getOrCreateUniqueId()).called(1);
      verify(mockTokenRemoteDataSource.getToken(deviceId: 'test_device_id'))
          .called(1);
      verify(mockTokenLocalDataSource.setToken(token: 'test_token')).called(1);

      expect(result, const Right<dynamic, dynamic>(null));
    });

    test('getToken returns failure when an error occurs', () async {
      when(mockDeviceIdDatasource.getOrCreateUniqueId())
          .thenThrow(Exception('test_exception'));

      final result = await tokenRepository.createToken();

      result.fold(
        (failure) => expect(failure, isA<GetTokenFailure>()),
        (_) => fail('Expected a Left'),
      );
    });
  });
}
