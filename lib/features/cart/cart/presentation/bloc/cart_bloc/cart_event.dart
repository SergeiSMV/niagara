part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.getCart() = _GetCart;

  /// Добавляет товар в корзину или увеличивает его количество на `1`.
  const factory CartEvent.addToCart({
    required Product product,
    bool? prepaidWater,
  }) = _AddToCart;

  /// Удаляет товар из корзины или уменьшает его количество на `1`.
  const factory CartEvent.removeFromCart({
    required Product product,
    bool? all,
    bool? prepaidWater,
  }) = _RemoveFromCart;

  // /// Добавляет предоплатную воду на списание в корзину.
  // const factory CartEvent.addPrepaidWaterToCart({
  //   required Product product,
  // }) = _AddPrepaidWaterToCart;

  // /// Удаляет предоплатную воду на списание из корзины.
  // const factory CartEvent.removePrepaidWaterFromCart({
  //   required Product product,
  // }) = _RemovePrepaidWaterFromCart;

  const factory CartEvent.removeAllFromCart({required CartClearTypes type}) =
      _RemoveAllFromCart;

  const factory CartEvent.toggleAllTare() = _ToggleAllTare;

  const factory CartEvent.setReturnTareCount({
    required int count,
  }) = _SetReturnTareCount;

  const factory CartEvent.setBonusesToPay({
    required int bonuses,
  }) = _SetBonusesToPay;

  const factory CartEvent.setPromocode({
    required String promocode,
  }) = _SetPromocode;
}
