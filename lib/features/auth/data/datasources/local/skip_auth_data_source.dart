import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Интерфейс локального источника данных для сохранения флага
/// о пропуске авторизации.
abstract interface class ISkipAuthLocalDataSource {
  /// Сохраняет флаг пропуска авторизации.
  Future<void> cacheSkipAuth({required bool skipAuth});

  /// Получает флаг пропуска авторизации.
  Future<bool> getSkipAuth();
}

/// Локальный источник данных для сохранения флага о пропуске авторизации.
@LazySingleton(as: ISkipAuthLocalDataSource)
class SkipAuthLocalDataSource implements ISkipAuthLocalDataSource {
  /// Конструктор локального источника данных.
  SkipAuthLocalDataSource({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  String get _skipAuthKey => 'skipAuth';

  @override
  Future<void> cacheSkipAuth({required bool skipAuth}) =>
      _sharedPreferences.setBool(_skipAuthKey, skipAuth);

  @override
  Future<bool> getSkipAuth() =>
      Future.value(_sharedPreferences.getBool(_skipAuthKey) ?? false);
}
