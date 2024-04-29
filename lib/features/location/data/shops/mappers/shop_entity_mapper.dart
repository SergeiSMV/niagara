import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/shops/local/entities/shop_entity.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';

extension ShopEntityMapper on ShopEntity {
  Shop toModel() => Shop(
        id: id,
        coordinates: (latitude, longitude),
        province: province,
        locality: locality,
        workTime: workTime.map((e) => e.toModel()).toList(),
      );

  ShopsTableCompanion toCompanion() => ShopsTableCompanion(
        id: Value(id),
        latitude: Value(latitude),
        longitude: Value(longitude),
        province: Value(province),
        locality: Value(locality),
        workTime: Value(workTime),
      );
}

extension ShopWorkTimeEntityMapper on ShopWorkTimeEntity {
  ShopWorkTime toModel() => ShopWorkTime(
        day: day,
        timeStart: timeStart,
        timeEnd: timeEnd,
      );

  ShopWorkTimeEntity toEntity() => ShopWorkTimeEntity(
        day: day,
        timeStart: timeStart,
        timeEnd: timeEnd,
      );
}

extension ShopsTableExtension on ShopsTableData {
  ShopEntity toEntity() => ShopEntity(
        id: id,
        latitude: latitude,
        longitude: longitude,
        province: province,
        locality: locality,
        workTime: workTime.map((e) => e.toEntity()).toList(),
      );
}
