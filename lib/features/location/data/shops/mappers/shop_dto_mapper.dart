import 'package:niagara_app/features/location/data/shops/local/entities/shop_entity.dart';
import 'package:niagara_app/features/location/data/shops/remote/dto/shop_dto.dart';

extension ShopDtoMapper on ShopDto {
  ShopEntity toEntity() => ShopEntity(
        id: id,
        latitude: latitude,
        longitude: longitude,
        province: '',
        locality: address,
        workTime: workTimes != null
            ? workTimes!.map((time) => time.toEntity()).toList()
            : [],
      );
}

extension ShopWorkTimeDtoMapper on StoreWorkTimeDto {
  ShopWorkTimeEntity toEntity() => ShopWorkTimeEntity(
        day: storeDay,
        timeStart: storeTimeBegin,
        timeEnd: storeTimeEnd,
      );
}
