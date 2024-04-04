import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/common/data/models/token.dart';
import 'package:niagara_app/core/core.dart';

import 'token_remote_datasource_test.mocks.dart';

@GenerateMocks([RequestHandler])
void main() {
  provideDummy<Either<Failure, TokenModel>>(
    const Right(
      TokenModel(
        isValid: true,
        token: 'test_token',
      ),
    ),
  );

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
          await tokenRemoteDataSource.onGetToken(deviceId: 'test_device_id');

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
      ).thenAnswer((_) async => const Left(TokenRemoteFailure()));

      final result =
          await tokenRemoteDataSource.onGetToken(deviceId: 'test_device_id');

      expect(
        result,
        equals(const Left<Failure, dynamic>(TokenRemoteFailure())),
      );
      verify(
        mockRequestHandler.sendRequest<String>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      );
    });

    test('onCheckToken returns true when token is valid', () async {
      when(
        mockRequestHandler.sendRequest<TokenModel>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).thenAnswer(
        (_) async => const Right(
          TokenModel(
            isValid: true,
            token: 'valid_token',
          ),
        ),
      );

      final result =
          await tokenRemoteDataSource.onCheckToken(token: 'valid_token');

      expect(
        result,
        const Right<dynamic, dynamic>(
          TokenModel(isValid: true, token: 'valid_token'),
        ),
      );
      verify(
        mockRequestHandler.sendRequest<TokenModel>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      );
    });

    test('onCheckToken returns false when token is invalid', () async {
      when(
        mockRequestHandler.sendRequest<TokenModel>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      ).thenAnswer((_) async => const Left(TokenRemoteFailure()));

      final result =
          await tokenRemoteDataSource.onCheckToken(token: 'invalid_token');

      expect(
        result,
        const Left<Failure, dynamic>(TokenRemoteFailure()),
      );

      verify(
        mockRequestHandler.sendRequest<TokenModel>(
          request: anyNamed('request'),
          converter: anyNamed('converter'),
          failure: anyNamed('failure'),
        ),
      );
    });
  });
}
