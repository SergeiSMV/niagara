part of 'locations_bloc.dart';

@freezed
class LocationsEvent with _$LocationsEvent {
  const factory LocationsEvent.initial() = _InitialEvent;

  const factory LocationsEvent.loadLocations() = _LoadLocationsEvent;

  const factory LocationsEvent.addLocation(Location location) =
      _AddLocationEvent;

  const factory LocationsEvent.updateLocation(Location location) =
      _UpdateLocationEvent;

  const factory LocationsEvent.deleteLocation(Location location) =
      _DeleteLocationEvent;

  const factory LocationsEvent.setDefaultLocation(Location location) =
      _SetDefaultLocationEvent;
}
