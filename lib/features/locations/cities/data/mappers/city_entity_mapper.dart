import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/locations/cities/data/local/entities/city_entity.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';

extension CityEntityMapper on CityEntity {
  City toModel() => City(
        id: id,
        coordinates: (latitude, longitude),
        province: province,
        locality: locality,
        phone: phone,
        searchSpan: diffLat != null && diffLong != null
            ? (diffLat: diffLat!, diffLong: diffLong!)
            : null,
      );

  CitiesTableCompanion toCompanion() => CitiesTableCompanion(
        id: Value(id),
        province: Value(province),
        locality: Value(locality),
        latitude: Value(latitude),
        longitude: Value(longitude),
        phone: Value(phone),
        diffLat: Value(diffLat),
        diffLong: Value(diffLong),
      );
}

extension CityMapper on City {
  CityEntity toEntity() => CityEntity(
        id: id,
        province: province,
        locality: locality,
        latitude: coordinates.$1,
        longitude: coordinates.$2,
        phone: phone,
        diffLat: searchSpan?.diffLat,
        diffLong: searchSpan?.diffLong,
      );
}

extension CitiesTableExtension on CitiesTableData {
  CityEntity toEntity() => CityEntity(
        id: id,
        province: province,
        locality: locality,
        latitude: latitude,
        longitude: longitude,
        phone: phone,
        diffLat: diffLat,
        diffLong: diffLong,
      );
}
