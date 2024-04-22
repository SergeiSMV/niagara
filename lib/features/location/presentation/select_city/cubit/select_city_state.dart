part of 'select_city_cubit.dart';

@freezed
class SelectCityState with _$SelectCityState {
  const factory SelectCityState.initial() = _Initial;
  const factory SelectCityState.loading() = _Loading;
  const factory SelectCityState.loaded({
    required List<Location> cities,
  }) = _Loaded;
  const factory SelectCityState.error() = _Error;
}
