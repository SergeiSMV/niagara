part of 'shops_bloc.dart';

@freezed
class ShopsState with _$ShopsState {
  const ShopsState._();

  const factory ShopsState.initial() = _Initial;
  const factory ShopsState.loading() = _Loading;
  const factory ShopsState.loaded({required List<Shop> shops}) = _Loaded;
  const factory ShopsState.selectShop({
    required Shop shop,
    required List<Shop> shops,
  }) = _SelectShop;
  const factory ShopsState.error(String message) = _Error;

  List<Shop> get shops => maybeWhen(
        loaded: (shops) => shops,
        selectShop: (_, shops) => shops,
        orElse: () => <Shop>[],
      );

  bool get hasShops => shops.isNotEmpty;
}
