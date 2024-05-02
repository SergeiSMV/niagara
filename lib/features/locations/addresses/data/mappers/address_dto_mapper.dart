import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/locations/addresses/data/local/entities/addresses_entity.dart';
import 'package:niagara_app/features/locations/addresses/data/remote/dto/address_dto.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';

extension AddressDtoMapper on AddressDto {
  AddressEntity toEntity({required int id}) => AddressEntity(
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

extension AddressMapper on Address {
  AddressDto toDto() => AddressDto(
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
