import 'package:niagara_app/features/home/data/dto/banner_dto.dart';
import 'package:niagara_app/features/home/domain/models/banner.dart';

extension BannerMapper on BannerDto {
  Banner toModel() {
    return Banner(
      id: id,
      name: name,
      imageUrl: imageUrl,
      link: link.isNotEmpty ? link : null,
      type: BannerType.fromString(type),
    );
  }
}
