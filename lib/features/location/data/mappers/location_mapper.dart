import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/data/models/location_model.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';

extension LocationMapper on LocationModel {
  Location toLocation() {
    return Location(
      coordinates: (latitude, longitude),
      province: province,
      locality: city.isNotEmpty ? city : locality,
      precision: precision,
      name: name,
      description: description,
      district: district,
      street: street,
      house: house,
      flat: flat,
      entrance: entrance,
      floor: floor,
      isPrimary: isPrimary,
    );
  }
}

extension LocationModelMapper on Location {
  LocationModel toModel({
    LocationPrecision? precision,
    bool? isPrimary,
  }) {
    return LocationModel(
      latitude: coordinates.$1,
      longitude: coordinates.$2,
      province: province,
      city: locality,
      locality: locality,
      district: district,
      street: street,
      house: house ?? '',
      floor: floor ?? '',
      flat: flat ?? '',
      entrance: entrance ?? '',
      name: name,
      description: description,
      precision: precision ?? this.precision,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}
