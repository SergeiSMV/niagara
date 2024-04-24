part of 'select_city_cubit.dart';

@freezed
class SelectCityState with _$SelectCityState {
  const factory SelectCityState.initial() = _Initial;
  const factory SelectCityState.loading() = _Loading;
  const factory SelectCityState.loaded({
    required List<City> cities,
  }) = _Loaded;
  const factory SelectCityState.selected({
    required City city,
  }) = _Selected;
  const factory SelectCityState.error() = _Error;
}
