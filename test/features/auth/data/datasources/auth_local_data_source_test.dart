import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/utils/constants/keys_constants.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late IAuthLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  const authStatusKey = KeysConst.kAuthStatus;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AuthLocalDataSource(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('AuthLocalDataSource', () {
    test('onSetAuthStatus saves status to shared preferences', () async {
      when(mockSharedPreferences.setInt(any, any))
          .thenAnswer((_) async => true);

      await dataSource.setAuthStatus(
        status: AuthenticatedStatus.authenticated.index,
      );

      verify(
        mockSharedPreferences.setInt(
          authStatusKey,
          AuthenticatedStatus.authenticated.index,
        ),
      ).called(1);
    });

    test('onCheckAuthStatus returns saved status from shared preferences',
        () async {
      when(mockSharedPreferences.getInt(any))
          .thenReturn(AuthenticatedStatus.authenticated.index);

      final result = await dataSource.checkAuthStatus();

      expect(result, AuthenticatedStatus.authenticated.index);
      verify(mockSharedPreferences.getInt(authStatusKey)).called(1);
    });
  });
}
