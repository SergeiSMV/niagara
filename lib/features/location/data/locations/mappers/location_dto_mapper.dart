import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/data/locations/local/entities/location_entity.dart';
import 'package:niagara_app/features/location/data/locations/remote/dto/location_dto.dart';

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
      );
}
