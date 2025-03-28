part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  /// Получает данные корзины.
  const factory CartEvent.getCart() = _GetCart;

  /// Выход из аккаунта.
  const factory CartEvent.loggedOut() = _LoggedOut;

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

  const factory CartEvent.removeAllFromCart({required CartClearTypes type}) =
      _RemoveAllFromCart;

  const factory CartEvent.toggleAllTare() = _ToggleAllTare;

  const factory CartEvent.toggleAllOtherTare() = _ToggleAllOtherTare;

  const factory CartEvent.setReturnTareCount({
    required int count,
  }) = _SetReturnTareCount;

  const factory CartEvent.setOtherReturnTareCount({
    required int count,
  }) = _SetOtherReturnTareCount;

  const factory CartEvent.setBonusesToPay({
    required int bonuses,
  }) = _SetBonusesToPay;

  const factory CartEvent.setPromocode({
    required String promocode,
  }) = _SetPromocode;
}
