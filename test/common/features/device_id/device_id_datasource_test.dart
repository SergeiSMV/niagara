import 'package:device_info_plus/device_info_plus.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/core.dart';

import 'device_id_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DeviceInfoPlugin>(),
  MockSpec<FlutterSecureStorage>(),
])
void main() {
  late MockDeviceInfoPlugin mockDeviceInfoPlugin;
  late MockFlutterSecureStorage mockSecureStorage;
  late DeviceIdDatasource datasource;

  setUp(() {
    mockDeviceInfoPlugin = MockDeviceInfoPlugin();
    mockSecureStorage = MockFlutterSecureStorage();
    datasource = DeviceIdDatasource(
      deviceInfoPlugin: mockDeviceInfoPlugin,
      secureStorage: mockSecureStorage,
    );
  });

  group('getOrCreateUniqueId', () {
    const deviceId = 'unique-device-id';
    test('should return existing device ID when available', () async {
      // Arrange
      when(mockSecureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => deviceId);

      // Act
      final result = await datasource.getOrCreateUniqueId();

      // Assert
      expect(result, const Right<dynamic, String>(deviceId));
      verify(mockSecureStorage.read(key: anyNamed('key'))).called(1);
      verifyNoMoreInteractions(mockDeviceInfoPlugin);
    });

    test('should return failure when unable to retrieve or create device ID',
        () async {
      // Arrange
      when(mockSecureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => null);
      when(mockDeviceInfoPlugin.deviceInfo).thenThrow(Exception('Error'));

      // Act
      final result = await datasource.getOrCreateUniqueId();

      // Assert
      expect(result, isA<Left<Failure, String>>());
    });
  });

  group('getUniqueId', () {
    const deviceId = 'unique-device-id';
    test('should return device ID when available', () async {
      // Arrange
      when(mockSecureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => deviceId);

      // Act
      final result = await datasource.getUniqueId();

      // Assert
      expect(result, const Right<dynamic, String>(deviceId));
    });

    test('should return failure when device ID is not available', () async {
      // Arrange
      when(mockSecureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => null);

      // Act
      final result = await datasource.getUniqueId();

      // Assert
      expect(result, isA<Left<Failure, String>>());
    });
  });
}
