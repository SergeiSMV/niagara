part of 'receipt_cubit.dart';

@freezed
class OrderReceiptState with _$OrderReceiptState {
  /// Начальное  состояние. Загрузка не была инициализирована.
  const factory OrderReceiptState.initial() = _Initial;

  /// Состояние загрузки.
  const factory OrderReceiptState.loading() = _Loading;

  /// Чек загружен.
  const factory OrderReceiptState.loaded({
    required OrderReceipt orderReceipt,
  }) = _Loaded;

  /// Ошибка загрузки чека.
  const factory OrderReceiptState.error() = _Error;
}
