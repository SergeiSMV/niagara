import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/features/home/data/dto/banner_dto.dart';
import 'package:niagara_app/features/home/domain/models/banner.dart';

extension BannerMapper on BannerDto {
  Banner toModel() {
    final bannerType = BannerType.fromString(type);
    return Banner(
      id: id,
      name: name,
      imageUrl: imageUrl,
      link: link.isNotEmpty ? link : null,
      type: bannerType,
      product: bannerType == BannerType.product && data != null
          ? ProductDto.fromJson(data!).toModel()
          : null,
    );
  }
}
