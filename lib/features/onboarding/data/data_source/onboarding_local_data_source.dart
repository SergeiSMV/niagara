import 'package:niagara_app/core/common/data/database/_imports.dart';
import 'package:niagara_app/core/utils/constants/keys_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Локальный источник данных для статуса прохождения онбординга.
abstract interface class IOnboardingLocalDataSource {
  /// Устанавливает статус прохождения онбординга `true`.
  Future<void> setPassed();

  /// Проверяет, прошел ли пользователь онбординг.
  bool isPassed();
}

@LazySingleton(as: IOnboardingLocalDataSource)
class OnboardingLocalDataSource implements IOnboardingLocalDataSource {
  OnboardingLocalDataSource(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  String get _key => KeysConst.kOnboardingPassed;

  @override
  bool isPassed() => _sharedPreferences.getBool(_key) ?? false;

  @override
  Future<void> setPassed() => _sharedPreferences.setBool(_key, true);
}
