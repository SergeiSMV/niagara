import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/locations/local/entities/location_entity.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';

extension LocationEntityMapper on LocationEntity {
  Location toModel() => Location(
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
      );

  LocationsTableCompanion toCompanion() => LocationsTableCompanion(
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
      );
}

extension LocationMapper on Location {
  LocationEntity toEntity({bool? isDefault}) => LocationEntity(
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
      );
}

extension LocationsTableExtension on LocationsTableData {
  LocationEntity toEntity() => LocationEntity(
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
      );
}
