import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Абстракция локального источника данных для авторизации.
abstract interface class IAuthLocalDataSource {
  /// Устанавливает статус авторизации.
  Future<void> onSetAuthStatus({required int status});

  /// Проверяет статус авторизации.
  Future<int> onCheckAuthStatus();
}

/// Реализация локального источника данных для авторизации.
@LazySingleton(as: IAuthLocalDataSource)
class AuthLocalDataSource implements IAuthLocalDataSource {
  /// Конструктор локального источника данных.
  AuthLocalDataSource({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  String get _skipAuthKey => 'skipAuth';

  @override
  Future<void> onSetAuthStatus({required int status}) =>
      _sharedPreferences.setInt(_skipAuthKey, status);

  @override
  Future<int> onCheckAuthStatus() =>
      Future.value(_sharedPreferences.getInt(_skipAuthKey) ?? 0);
}
