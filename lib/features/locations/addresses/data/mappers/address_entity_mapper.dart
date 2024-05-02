import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/locations/addresses/data/local/entities/addresses_entity.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';

extension AddressEntityMapper on AddressEntity {
  Address toModel() => Address(
        id: id,
        coordinates: (latitude, longitude),
        province: province,
        locality: locality,
        district: district,
        street: street,
        house: house,
        flat: flat,
        entrance: entrance,
        floor: floor,
        name: name,
        description: description,
        precision: precision,
        isDefault: isDefault,
        locationId: locationId,
      );

  AddressesTableCompanion toCompanion() => AddressesTableCompanion(
        id: Value(id),
        latitude: Value(latitude),
        longitude: Value(longitude),
        province: Value(province),
        locality: Value(locality),
        district: Value(district),
        street: Value(street),
        house: Value(house),
        flat: Value(flat),
        entrance: Value(entrance),
        floor: Value(floor),
        name: Value(name),
        description: Value(description),
        precision: Value(precision),
        isDefault: Value(isDefault),
        locationId: Value(locationId),
      );
}

extension AddressMapper on Address {
  AddressEntity toEntity({
    bool? isDefault,
    String? locationId,
  }) =>
      AddressEntity(
        id: id,
        latitude: coordinates.$1,
        longitude: coordinates.$2,
        province: province,
        locality: locality,
        district: district,
        street: street,
        house: house,
        flat: flat,
        entrance: entrance,
        floor: floor,
        name: name,
        description: description,
        precision: precision,
        isDefault: isDefault ?? this.isDefault,
        locationId: locationId ?? this.locationId,
      );
}

extension AddressesTableExtension on AddressesTableData {
  AddressEntity toEntity() => AddressEntity(
        id: id,
        latitude: latitude,
        longitude: longitude,
        province: province,
        locality: locality,
        district: district,
        street: street,
        house: house,
        flat: flat,
        entrance: entrance,
        floor: floor,
        name: name,
        description: description,
        precision: precision,
        isDefault: isDefault,
        locationId: locationId,
      );
}
