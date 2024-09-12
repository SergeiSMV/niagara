part of 'water_balance_cubit.dart';

@freezed
class WaterBalanceState with _$WaterBalanceState {
  /// Загрузка данных.
  const factory WaterBalanceState.loading() = _Loading;

  /// Данные загружены.
  const factory WaterBalanceState.loaded({
    required Bottles balance,
  }) = _Loaded;

  /// Данные загружены и баланс пуст.
  const factory WaterBalanceState.empty() = _Empty;

  /// Ошибка загрузки данных.
  const factory WaterBalanceState.error() = _Error;

  /// Неавторизованный пользователь.
  const factory WaterBalanceState.unauthorized() = _Unauthorized;
}
