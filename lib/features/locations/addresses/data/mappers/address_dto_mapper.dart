import '../../../../../core/utils/enums/location_precision.dart';
import '../../domain/models/address.dart';
import '../local/entities/addresses_entity.dart';
import '../remote/dto/address_dto.dart';

/// Маппер для преобразования DTO в Entity
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

/// Маппер для преобразования Address в DTO
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
        name: _buildFullName(),
        description: description,
        isDefault: isDefault,
        locationId: locationId,
      );

  String _buildFullName() {
    final parts = <String>[];

    if (district.isNotEmpty) parts.add(district);
    if (locality.isNotEmpty) parts.add(locality);
    if (street.isNotEmpty) parts.add(street);
    if (house.isNotEmpty) parts.add('д $house');
    if (flat.isNotEmpty) parts.add(flat);

    return parts.join(', ');
  }
}
