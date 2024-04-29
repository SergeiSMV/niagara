import 'package:niagara_app/features/location/data/shops/remote/dto/shop_dto.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';

extension ShopDtoMapper on ShopDto {
  Shop toModel() => Shop(
        id: id,
        coordinates: (latitude, longitude),
        province: '',
        locality: address,
        workTime: workTimes != null
            ? workTimes!.map((time) => time.toModel()).toList()
            : [],
      );
}

extension ShopWorkTimeDtoMapper on StoreWorkTimeDto {
  ShopWorkTime toModel() => ShopWorkTime(
        day: storeDay,
        timeStart: storeTimeBegin,
        timeEnd: storeTimeEnd,
      );
}
