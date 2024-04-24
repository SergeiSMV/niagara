part of 'locations_bloc.dart';

@freezed
class LocationsState with _$LocationsState {
  const factory LocationsState.initial() = _Initial;
  const factory LocationsState.loading() = _Loading;
  const factory LocationsState.loaded({
    required City city,
    required List<Location> locations,
  }) = _Loaded;
  const factory LocationsState.error() = _Error;
}
