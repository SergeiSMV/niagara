import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/data/locations/local/entities/location_entity.dart';
import 'package:niagara_app/features/location/data/locations/remote/dto/location_dto.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';

extension LocationDtoMapper on LocationDto {
  LocationEntity toEntity({
    required int id,
  }) =>
      LocationEntity(
        id: id,
        latitude: latitude,
        longitude: longitude,
        province: region,
        locality: location.isNotEmpty ? location : city,
        district: district,
        street: street,
        house: build,
        flat: flat,
        entrance: entrance,
        floor: floor,
        name: name,
        description: description,
        precision: LocationPrecision.parse(
          street: street,
          house: build,
        ),
        isDefault: isDefault,
        locationId: locationId,
      );
}

extension LocationMapper on Location {
  LocationDto toDto() => LocationDto(
        latitude: coordinates.$1,
        longitude: coordinates.$2,
        region: province,
        city: locality,
        location: locality,
        district: district,
        street: street,
        build: house,
        flat: flat,
        entrance: entrance,
        floor: floor,
        name: name,
        description: description,
        isDefault: isDefault,
        locationId: locationId,
      );
}
