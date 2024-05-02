import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/locations/shops/data/local/entities/shop_entity.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';

extension ShopEntityMapper on ShopEntity {
  Shop toModel() => Shop(
        id: id,
        coordinates: (latitude, longitude),
        province: province,
        locality: locality,
        storeDays: storeDays,
        openTime: openTime,
        closeTime: closeTime,
        schedule: schedule.map((e) => e.toModel()).toList(),
      );

  ShopsTableCompanion toCompanion() => ShopsTableCompanion(
        id: Value(id),
        province: Value(province),
        locality: Value(locality),
        latitude: Value(latitude),
        longitude: Value(longitude),
        storeDays: Value(storeDays),
        openTime: Value(openTime),
        closeTime: Value(closeTime),
        schedule: Value(schedule),
      );
}

extension ShopWorkTimeEntityMapper on ShopScheduleEntity {
  ShopSchedule toModel() => ShopSchedule(
        day: day,
        openTime: openTime,
        closeTime: closeTime,
      );

  ShopScheduleEntity toEntity() => ShopScheduleEntity(
        day: day,
        openTime: openTime,
        closeTime: closeTime,
      );
}

extension ShopsTableExtension on ShopsTableData {
  ShopEntity toEntity() => ShopEntity(
        id: id,
        province: province,
        locality: locality,
        latitude: latitude,
        longitude: longitude,
        storeDays: storeDays,
        openTime: openTime,
        closeTime: closeTime,
        schedule: schedule,
      );
}
