part of 'cities_cubit.dart';

@freezed
class CitiesState with _$CitiesState {
  const factory CitiesState.initial() = _Initial;

  const factory CitiesState.loading() = _Loading;

  const factory CitiesState.loaded({
    required List<City> cities,
  }) = _Loaded;

  const factory CitiesState.selected({
    required City city,
  }) = _Selected;
  
  const factory CitiesState.error() = _Error;
}
