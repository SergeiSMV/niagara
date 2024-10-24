import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';

/// Модель с данными о баннере.
class Banner extends Equatable {
  const Banner({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.link,
    this.product,
  });

  /// Идентификатор баннера.
  final String id;

  /// Название баннера.
  final String name;

  /// Ссылка на изображение баннера.
  final String imageUrl;

  /// Тип баннера.
  final BannerType? type;

  /// Ссылка на внешний ресурс или `ID` продукта, с которым связан баннер.
  final String? link;

  /// [Product], на который должен перенаправлять баннер.
  final Product? product;

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        type,
        link,
      ];
}

enum BannerType {
  product,
  offers,
  web;

  static BannerType? fromString(String? value) {
    final String? formatted = value?.toLowerCase();

    switch (formatted) {
      case 'product':
        return product;
      case 'offers':
        return offers;
      case 'web':
        return web;
      default:
        return null;
    }
  }
}
