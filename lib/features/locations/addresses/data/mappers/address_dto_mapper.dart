import '../../../../../core/utils/enums/location_precision.dart';
import '../../../../../core/utils/enums/locality_type.dart';
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
  AddressDto toDto() {
    // Определяем тип населенного пункта
    final localityType = locality.localityType;

    // Определяем поле CITY
    final city = localityType == LocalityType.city ? locality : '';

    // Если указан город - пустая строка, если не город - населенный пункт
    final location = localityType == LocalityType.city ? '' : locality;

    // Если указан город - пустая строка, иначе указываем район
    final finalDistrict = localityType == LocalityType.city ? '' : district;

    final dto = AddressDto(
      latitude: coordinates.$1,
      longitude: coordinates.$2,
      region: province, // область
      city: city, // город (если это город) или пустая строка
      location: location, // населенный пункт (если это не город)
      district: finalDistrict, // район, если это не город, иначе пустая строка
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

    return dto;
  }

  /// Строим полное имя адреса `NAME`
  String _buildFullName() {
    final parts = <String>[];

    if (district.isNotEmpty) parts.add(province);
    if (locality.isNotEmpty) parts.add(locality);
    if (street.isNotEmpty) parts.add(street);
    if (house.isNotEmpty) parts.add('д $house');
    if (flat.isNotEmpty) parts.add(flat);

    return parts.join(', ');
  }
}
