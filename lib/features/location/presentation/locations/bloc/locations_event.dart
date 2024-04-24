part of 'locations_bloc.dart';

@freezed
class LocationsEvent with _$LocationsEvent {
  const factory LocationsEvent.started() = _Started;
  const factory LocationsEvent.loadLocations() = _LoadLocations;
  const factory LocationsEvent.selectCity({
    required City city,
  }) = _SelectCity;
}
