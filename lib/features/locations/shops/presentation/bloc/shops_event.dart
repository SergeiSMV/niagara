part of 'shops_bloc.dart';

@freezed
class ShopsEvent with _$ShopsEvent {
  const factory ShopsEvent.loading() = _LoadingEvent;
  const factory ShopsEvent.selectShop({required Shop shop}) = _SelectShopEvent;
  const factory ShopsEvent.unselectShop() = _UnselectShopEvent;
}
