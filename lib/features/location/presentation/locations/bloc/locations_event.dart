part of 'locations_bloc.dart';

@freezed
class LocationsEvent with _$LocationsEvent {
  const factory LocationsEvent.loadLocations() = _LoadLocations;

  const factory LocationsEvent.addLocation(Location location) = _AddLocation;

  const factory LocationsEvent.updateLocation(Location location) =
      _UpdateLocation;

  const factory LocationsEvent.deleteLocation(Location location) =
      _DeleteLocation;
      
  const factory LocationsEvent.setDefaultLocation(Location location) =
      _SetDefaultLocation;
}
