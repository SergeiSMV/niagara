// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';

typedef ProductsDto = ({List<ProductDto> products, PaginationDto pagination});

class ProductDto extends Equatable {
  const ProductDto({
    this.productId,
    this.productName,
    this.productArticle,
    this.productImage,
    this.productDescription,
    this.productDescriptionFull,
    this.productGroupId,
    this.productGroupName,
    this.productType,
    this.productPrice,
    this.productPriceOld,
    this.productPriceVip,
    this.productMain,
    this.productTara,
    this.imagesArray,
    this.propertyArray,
    this.label,
    this.labelColor,
    this.discountOfCount,
    this.bonus,
    this.productCount,
    this.complectId,
  });

  final String? productId;
  final String? complectId;
  final String? productName;
  final String? productArticle;
  final String? productImage;
  final String? productDescription;
  final String? productDescriptionFull;
  final String? productGroupId;
  final String? productGroupName;
  final String? productType;
  final int? productPrice;
  final int? productPriceOld;
  final int? productPriceVip;
  final bool? productMain;
  final bool? productTara;
  final List<String>? imagesArray;
  final List<PropertyArrayDto>? propertyArray;
  final String? label;
  final String? labelColor;
  final String? discountOfCount;
  final int? bonus;
  final int? productCount;

  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
        productId: json['PRODUCT_ID'] as String?,
        complectId: json['COMPLECT_ID'] as String?,
        productName: json['PRODUCT_NAME'] as String?,
        productArticle: json['PRODUCT_ARTICLE'] as String?,
        productImage:
            (json['PRODUCT_IMAGE'] ?? json['PRODUCT_IMAGES']) as String?,
        productDescription: json['PRODUCT_DESCRIPTION'] as String?,
        productDescriptionFull: json['PRODUCT_DESCRIPTION_FULL'] as String?,
        productGroupId: json['PRODUCT_GROUP_ID'] as String?,
        productGroupName: json['PRODUCT_GROUP_NAME'] as String?,
        productType: json['PRODUCT_TYPE'] as String?,
        productPrice: (json['PRODUCT_PRICE'] as num?)?.toInt(),
        productPriceOld: (json['PRODUCT_PRICE_OLD'] as num?)?.toInt(),
        productPriceVip: (json['PRODUCT_PRICE_VIP'] as num?)?.toInt(),
        productMain: json['PRODUCT_MAIN'] as bool?,
        productTara: json['PRODUCT_TARA'] as bool?,
        imagesArray: (json['IMAGES_ARRAY'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        propertyArray: (json['PROPERTY_ARRAY'] as List<dynamic>?)
            ?.map((e) => PropertyArrayDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        label: json['LABEL'] as String?,
        labelColor: json['LABEL_COLOR'] as String?,
        discountOfCount: json['DISCOUNT_OF_COUNT'] as String?,
        bonus: (json['BONUS'] as num?)?.toInt(),
        productCount: (json['PRODUCT_COUNT'] as num?)?.toInt(),
      );

  @override
  List<Object?> get props => [
        productId,
        productName,
        productArticle,
        productImage,
        productDescription,
        productDescriptionFull,
        productGroupId,
        productGroupName,
        productType,
        productPrice,
        productPriceOld,
        productPriceVip,
        productMain,
        productTara,
        imagesArray,
        propertyArray,
        label,
        labelColor,
        discountOfCount,
        bonus,
        productCount,
      ];
}

class PropertyArrayDto extends Equatable {
  const PropertyArrayDto({
    this.propertyId,
    this.propertyName,
    this.propertyValue,
  });

  final String? propertyId;
  final String? propertyName;
  final String? propertyValue;

  factory PropertyArrayDto.fromJson(Map<String, dynamic> json) =>
      PropertyArrayDto(
        propertyId: json['PROPERTY_ID'] as String?,
        propertyName: json['PROPERTY_NAME'] as String?,
        propertyValue: json['PROPERTY_VALUE'] as String?,
      );

  @override
  List<Object?> get props => [
        propertyId,
        propertyName,
        propertyValue,
      ];
}
