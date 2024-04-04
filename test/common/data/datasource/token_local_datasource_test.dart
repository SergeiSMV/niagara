import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:uuid/uuid.dart';

import 'token_local_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterSecureStorage>(),
  MockSpec<Uuid>(),
])
class MockDotEnv extends Mock implements DotEnv {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockDotEnv().testLoad();

  const token = 'token_test';
  const tokenKey = ApiConst.kToken;
  const deviceId = ApiConst.kDeviceId;

  group('TokenLocalDataSource', () {
    late TokenLocalDataSource datasource;
    late FlutterSecureStorage storage;
    late MockUuid uuid;

    setUp(() {
      storage = MockFlutterSecureStorage();
      uuid = MockUuid();
      datasource = TokenLocalDataSource(
        storage: storage,
        uuid: uuid,
      );
    });

    test('onSetToken', () async {
      // arrange

      when(storage.write(key: tokenKey, value: token))
          .thenAnswer((_) => Future.value());

      // act
      await datasource.onSetToken(token: token);

      // assert
      verify(storage.write(key: tokenKey, value: token)).called(1);
    });

    test('onGetToken', () async {
      // arrange
      when(storage.read(key: tokenKey))
          .thenAnswer((_) async => Future.value(token));

      // act
      final result = await datasource.onGetToken();

      // assert
      expect(result, token);
    });

    test('onDeleteToken', () async {
      // act
      await datasource.onDeleteToken();

      // assert
      verify(storage.delete(key: tokenKey)).called(1);
    });

    test('onGetDeviceId', () async {
      // arrange
      when(uuid.v4()).thenReturn(deviceId);

      // act
      final result = await datasource.onGetDeviceId();

      // assert
      expect(result, deviceId);
    });
  });
}
