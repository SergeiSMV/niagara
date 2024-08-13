part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.getCart({String? promoCode}) = _GetCart;

  const factory CartEvent.addToCart({
    required Product product,
  }) = _AddToCart;

  const factory CartEvent.removeFromCart({
    required Product product,
  }) = _RemoveFromCart;

  const factory CartEvent.removeAllFromCart({required CartClearTypes type}) =
      _RemoveAllFromCart;

  const factory CartEvent.toggleAllTare() = _ToggleAllTare;

  const factory CartEvent.setReturnTareCount({
    required int count,
  }) = _SetReturnTareCount;

  const factory CartEvent.setBonusesToPay({
    required int bonuses,
  }) = _SetBonusesToPay;
}
