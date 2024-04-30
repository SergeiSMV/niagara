import 'package:niagara_app/features/location/data/shops/local/entities/shop_entity.dart';
import 'package:niagara_app/features/location/data/shops/remote/dto/shop_dto.dart';

extension ShopDtoMapper on ShopDto {
  ShopEntity toEntity() => ShopEntity(
        id: id,
        province: '',
        locality: address,
        latitude: latitude,
        longitude: longitude,
        storeDays: storeDay ?? 0,
        openTime: storeTimeBegin ?? '',
        closeTime: storeTimeEnd ?? '',
        schedule: workTimes != null
            ? workTimes!.map((time) => time.toEntity()).toList()
            : [],
      );
}

extension ShopWorkTimeDtoMapper on StoreWorkTimeDto {
  ShopScheduleEntity toEntity() => ShopScheduleEntity(
        day: storeDay,
        openTime: storeTimeBegin,
        closeTime: storeTimeEnd,
      );
}
