import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/common/data/services/device_id_service.dart';
import 'package:niagara_app/core/core.dart' hide test;
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/network/network_info.dart';
import 'package:niagara_app/features/authorization/base_token/data/data_sources/token_local_data_source.dart';
import 'package:niagara_app/features/authorization/base_token/data/data_sources/token_remote_data_source.dart';
import 'package:niagara_app/features/authorization/base_token/data/repositories/token_repository.dart';
import 'package:niagara_app/features/authorization/base_token/domain/repositories/token_repository.dart';

import 'token_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ITokenRemoteDataSource>(),
  MockSpec<ITokenLocalDataSource>(),
  MockSpec<IDeviceIdService>(),
  MockSpec<IAppLogger>(),
  MockSpec<INetworkInfo>(),
])
void main() {
  late ITokenRepository tokenRepository;
  late MockITokenRemoteDataSource mockTokenRemoteDataSource;
  late MockITokenLocalDataSource mockTokenLocalDataSource;
  late MockIDeviceIdService mockDeviceIdService;
  late IAppLogger mockLogger;
  late INetworkInfo mockNetworkInfo;

  provideDummy<Either<Failure, void>>(const Right(null));
  provideDummy<Either<Failure, void>>(const Left(TokenRepositoryFailure()));

  provideDummy<Either<Failure, String>>(const Right('cached_token'));
  provideDummy<Either<Failure, String>>(const Left(GetTokenFailure()));

  setUpAll(() {
    getIt.registerSingleton<IAppLogger>(MockIAppLogger());
    mockTokenRemoteDataSource = MockITokenRemoteDataSource();
    mockTokenLocalDataSource = MockITokenLocalDataSource();
    mockDeviceIdService = MockIDeviceIdService();
    mockLogger = getIt.get<IAppLogger>();
    mockNetworkInfo = getIt.get<INetworkInfo>();
    tokenRepository = TokenRepository(
      mockLogger,
      mockNetworkInfo,
      mockTokenRemoteDataSource,
      mockTokenLocalDataSource,
      mockDeviceIdService,
    );
  });

  group('TokenRepository', () {
    test('getToken returns cached token if available', () async {
      when(mockTokenLocalDataSource.getToken())
          .thenAnswer((_) async => 'cached_token');

      final result = await tokenRepository.getToken();

      expect(result, const Right<Failure, String>('cached_token'));
      verifyNever(mockDeviceIdService.getUniqueId());
      verifyNever(
        mockTokenRemoteDataSource.getToken(deviceId: anyNamed('deviceId')),
      );
      verifyNever(mockTokenLocalDataSource.setToken(token: anyNamed('token')));
    });

    test('getToken throws TokenNotFoundFailure if local token is null or empty',
        () async {
      when(mockTokenLocalDataSource.getToken()).thenAnswer((_) async => null);

      final result = await tokenRepository.getToken();

      expect(result, const Left<Failure, String>(GetTokenFailure()));
      verifyNever(mockDeviceIdService.getUniqueId());
      verifyNever(
        mockTokenRemoteDataSource.getToken(deviceId: anyNamed('deviceId')),
      );
      verifyNever(mockTokenLocalDataSource.setToken(token: anyNamed('token')));
    });

    test('createToken throws DeviceIdFailure if device id fails', () async {
      when(mockDeviceIdService.getUniqueId())
          .thenAnswer((_) async => const Left(DeviceIdFailure()));

      final result = await tokenRepository.createToken();

      expect(result, const Left<Failure, void>(TokenRepositoryFailure()));
      verify(mockDeviceIdService.getUniqueId()).called(1);
      verifyNever(
        mockTokenRemoteDataSource.getToken(deviceId: anyNamed('deviceId')),
      );
      verifyNever(mockTokenLocalDataSource.setToken(token: anyNamed('token')));
    });

    test('createToken throws GetTokenFailure if remote token fetch fails',
        () async {
      when(mockDeviceIdService.getUniqueId())
          .thenAnswer((_) async => const Right('test_device_id'));

      when(mockTokenRemoteDataSource.getToken(deviceId: 'test_device_id'))
          .thenAnswer((_) async => const Left(TokenRepositoryFailure()));

      final result = await tokenRepository.createToken();

      expect(result, const Left<Failure, void>(TokenRepositoryFailure()));
      verify(mockDeviceIdService.getUniqueId()).called(1);
      verify(mockTokenRemoteDataSource.getToken(deviceId: 'test_device_id'))
          .called(1);
      verifyNever(mockTokenLocalDataSource.setToken(token: anyNamed('token')));
    });
  });
}
