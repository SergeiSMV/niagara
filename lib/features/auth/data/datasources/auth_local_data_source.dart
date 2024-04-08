import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/constants/keys_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IAuthLocalDataSource {
  Future<void> onSetAuthStatus({required int status});

  Future<int> onCheckAuthStatus();
}

@LazySingleton(as: IAuthLocalDataSource)
class AuthLocalDataSource implements IAuthLocalDataSource {
  AuthLocalDataSource({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const _authStatusKey = KeysConst.kAuthStatus;

  @override
  Future<void> onSetAuthStatus({required int status}) =>
      _sharedPreferences.setInt(_authStatusKey, status);

  @override
  Future<int> onCheckAuthStatus() =>
      Future.value(_sharedPreferences.getInt(_authStatusKey) ?? 0);
}
