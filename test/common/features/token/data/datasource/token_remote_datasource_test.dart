import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart';

import 'token_remote_datasource_test.mocks.dart';

@GenerateMocks([RequestHandler])
void main() {
  provideDummy<Either<Failure, String>>(const Right('test_token'));

  group('TokenRemoteDataSource', () {
    late MockRequestHandler mockRequestHandler;
    late TokenRemoteDataSource tokenRemoteDataSource;

    setUp(() {
      mockRequestHandler = MockRequestHandler();
      tokenRemoteDataSource =
          TokenRemoteDataSource(requestHandler: mockRequestHandler);
    });

    test('onGetToken returns token when request is successful', () async {
      when(
        mockRequestHandler.sendRequest<String>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).thenAnswer((_) async => const Right('test_token'));

      final result =
          await tokenRemoteDataSource.getToken(deviceId: 'test_device_id');

      expect(result, equals(const Right<dynamic, dynamic>('test_token')));
      verify(
        mockRequestHandler.sendRequest<String>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      );
    });

    test('onGetToken returns empty string when request fails', () async {
      when(
        mockRequestHandler.sendRequest<String>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).thenAnswer((_) async => const Left(GetTokenFailure()));

      final result =
          await tokenRemoteDataSource.getToken(deviceId: 'test_device_id');

      expect(
        result,
        equals(const Left<Failure, dynamic>(GetTokenFailure())),
      );
      verify(
        mockRequestHandler.sendRequest<String>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      );
    });
  });
}
