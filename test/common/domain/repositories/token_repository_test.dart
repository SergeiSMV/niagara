import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/common/data/models/token.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/dependencies/di.dart';

import 'token_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ITokenRemoteDataSource>(),
  MockSpec<ITokenLocalDataSource>(),
  MockSpec<IAppLogger>(),
])
void main() {
  late TokenRepository tokenRepository;
  late MockITokenRemoteDataSource mockTokenRemoteDataSource;
  late MockITokenLocalDataSource mockTokenLocalDataSource;

  provideDummy<Either<Failure, TokenModel>>(
    const Right(
      TokenModel(
        isValid: true,
        token: 'test_token',
      ),
    ),
  );

  provideDummy<Either<Failure, String>>(const Right('test_token'));

  setUp(() {
    getIt.registerSingleton<IAppLogger>(MockIAppLogger());
    mockTokenRemoteDataSource = MockITokenRemoteDataSource();
    mockTokenLocalDataSource = MockITokenLocalDataSource();
    tokenRepository = TokenRepository(
      remoteDataSource: mockTokenRemoteDataSource,
      localDataSource: mockTokenLocalDataSource,
    );
  });

  group('TokenRepository', () {
    test('getToken gets device id, fetches token, and saves it', () async {
      when(mockTokenLocalDataSource.onGetDeviceId())
          .thenAnswer((_) async => 'test_device_id');

      when(mockTokenRemoteDataSource.onGetToken(deviceId: 'test_device_id'))
          .thenAnswer((_) async => const Right('test_token'));

      when(mockTokenLocalDataSource.onSetToken(token: 'test_token'))
          .thenAnswer((_) async => const Right<Failure, dynamic>(null));

      final result = await tokenRepository.onCreateToken();

      verify(mockTokenLocalDataSource.onGetDeviceId()).called(1);
      verify(mockTokenRemoteDataSource.onGetToken(deviceId: 'test_device_id'))
          .called(1);
      verify(mockTokenLocalDataSource.onSetToken(token: 'test_token'))
          .called(1);

      expect(result, const Right<dynamic, dynamic>(null));
    });

    test('getToken returns failure when an error occurs', () async {
      when(mockTokenLocalDataSource.onGetDeviceId())
          .thenThrow(Exception('test_exception'));

      final result = await tokenRepository.onCreateToken();

      result.fold(
        (failure) => expect(failure, isA<GetTokenFailure>()),
        (_) => fail('Expected a Left'),
      );
    });

    test('checkToken gets token from local data source', () async {
      when(mockTokenLocalDataSource.onGetToken())
          .thenAnswer((_) async => 'test_token');

      final result = await tokenRepository.onCheckToken();

      verify(mockTokenLocalDataSource.onGetToken()).called(1);

      expect(result, const Right<dynamic, dynamic>('test_token'));
    });

    test('checkToken returns failure when an error occurs', () async {
      when(mockTokenLocalDataSource.onGetToken())
          .thenThrow(Exception('test_exception'));

      final result = await tokenRepository.onCheckToken();

      result.fold(
        (failure) => expect(failure, isA<CheckTokenFailure>()),
        (_) => fail('Expected a Left'),
      );
    });
  });
}
