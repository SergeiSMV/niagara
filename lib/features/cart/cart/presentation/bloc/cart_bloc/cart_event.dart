part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.getCart({String? promoCode}) = _GetCart;

  /// Добавляет товар в корзину или увеличивает его количество на `1`.
  const factory CartEvent.addToCart({
    required Product product,
  }) = _AddToCart;

  /// Удаляет товар из корзины или уменьшает его количество на `1`.
  const factory CartEvent.removeFromCart({
    required Product product,
  }) = _RemoveFromCart;

  /// Добавляет предоплатную воду на списание в корзину.
  const factory CartEvent.addPrepaidWaterToCart({
    required Product product,
  }) = _AddPrepaidWaterToCart;

  /// Удаляет предоплатную воду на списание из корзины.
  const factory CartEvent.removePrepaidWaterFromCart({
    required Product product,
  }) = _RemovePrepaidWaterFromCart;

  const factory CartEvent.removeAllFromCart({required CartClearTypes type}) =
      _RemoveAllFromCart;

  // TODO: Нигде не используется
  const factory CartEvent.toggleAllTare() = _ToggleAllTare;

  // TODO: Нигде не используется
  const factory CartEvent.setReturnTareCount({
    required int count,
  }) = _SetReturnTareCount;

  // TODO: Нигде не используется
  const factory CartEvent.setBonusesToPay({
    required int bonuses,
  }) = _SetBonusesToPay;
}
