import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/features/authorization/base_token/data/data_sources/token_local_data_source.dart';
import 'package:niagara_app/core/utils/constants/keys_constants.dart';

import 'token_local_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterSecureStorage>(),
])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  const token = 'token_test';
  const tokenKey = KeysConst.kToken;

  group('TokenLocalDataSource', () {
    late TokenLocalDataSource datasource;
    late FlutterSecureStorage storage;

    setUp(() {
      storage = MockFlutterSecureStorage();

      datasource = TokenLocalDataSource(storage);
    });

    test('onSetToken', () async {
      // arrange

      when(storage.write(key: tokenKey, value: token))
          .thenAnswer((_) => Future.value());

      // act
      await datasource.setToken(token: token);

      // assert
      verify(storage.write(key: tokenKey, value: token)).called(1);
    });

    test('onGetToken', () async {
      // arrange
      when(storage.read(key: tokenKey))
          .thenAnswer((_) async => Future.value(token));

      // act
      final result = await datasource.getToken();

      // assert
      expect(result, token);
    });

    test('onDeleteToken', () async {
      // act
      await datasource.deleteToken();

      // assert
      verify(storage.delete(key: tokenKey)).called(1);
    });
  });
}
