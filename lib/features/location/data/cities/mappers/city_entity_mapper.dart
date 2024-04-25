import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/cities/local/entities/city_entity.dart';
import 'package:niagara_app/features/location/domain/models/city.dart';

extension CityEntityMapper on CityEntity {
  City toModel() => City(
        id: id,
        coordinates: (latitude, longitude),
        province: province,
        locality: locality,
      );

  CitiesTableCompanion toCompanion() => CitiesTableCompanion(
        id: Value(id),
        province: Value(province),
        locality: Value(locality),
        latitude: Value(latitude),
        longitude: Value(longitude),
      );
}

extension CityMapper on City {
  CityEntity toEntity() => CityEntity(
        id: id,
        province: province,
        locality: locality,
        latitude: coordinates.$1,
        longitude: coordinates.$2,
      );
}

extension CitiesTableExtension on CitiesTableData {
  CityEntity toEntity() => CityEntity(
        id: id,
        province: province,
        locality: locality,
        latitude: latitude,
        longitude: longitude,
      );
}
