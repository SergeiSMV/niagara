part of 'shops_bloc.dart';

@freezed
class ShopsState with _$ShopsState {
  const factory ShopsState.initial() = _Initial;
  const factory ShopsState.loading() = _Loading;
  const factory ShopsState.loaded(List<Shop> shops) = _Loaded;
  const factory ShopsState.error(String message) = _Error;
}
