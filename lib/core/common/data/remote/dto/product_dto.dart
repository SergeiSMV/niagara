// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';

part 'product_dto.g.dart';

typedef ProductsDto = ({List<ProductDto> products, PaginationDto pagination});

@JsonSerializable()
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
  });

  @JsonKey(name: 'PRODUCT_ID')
  final String? productId;
  @JsonKey(name: 'PRODUCT_NAME')
  final String? productName;
  @JsonKey(name: 'PRODUCT_ARTICLE')
  final String? productArticle;
  @JsonKey(name: 'PRODUCT_IMAGE')
  final String? productImage;
  @JsonKey(name: 'PRODUCT_DESCRIPTION')
  final String? productDescription;
  @JsonKey(name: 'PRODUCT_DESCRIPTION_FULL')
  final String? productDescriptionFull;
  @JsonKey(name: 'PRODUCT_GROUP_ID')
  final String? productGroupId;
  @JsonKey(name: 'PRODUCT_GROUP_NAME')
  final String? productGroupName;
  @JsonKey(name: 'PRODUCT_TYPE')
  final String? productType;
  @JsonKey(name: 'PRODUCT_PRICE')
  final int? productPrice;
  @JsonKey(name: 'PRODUCT_PRICE_OLD')
  final int? productPriceOld;
  @JsonKey(name: 'PRODUCT_PRICE_VIP')
  final int? productPriceVip;
  @JsonKey(name: 'PRODUCT_MAIN')
  final bool? productMain;
  @JsonKey(name: 'PRODUCT_TARA')
  final bool? productTara;
  @JsonKey(name: 'IMAGES_ARRAY')
  final List<String>? imagesArray;
  @JsonKey(name: 'PROPERTY_ARRAY')
  final List<PropertyArrayDto>? propertyArray;
  @JsonKey(name: 'LABEL')
  final String? label;
  @JsonKey(name: 'LABEL_COLOR')
  final String? labelColor;
  @JsonKey(name: 'DISCOUNT_OF_COUNT')
  final String? discountOfCount;
  @JsonKey(name: 'BONUS')
  final int? bonus;
  @JsonKey(name: 'PRODUCT_COUNT')
  final int? productCount;
  

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

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

@JsonSerializable()
class PropertyArrayDto extends Equatable {
  const PropertyArrayDto({
    this.propertyId,
    this.propertyName,
    this.propertyValue,
  });

  @JsonKey(name: 'PROPERTY_ID')
  final String? propertyId;
  @JsonKey(name: 'PROPERTY_NAME')
  final String? propertyName;
  @JsonKey(name: 'PROPERTY_VALUE')
  final String? propertyValue;

  factory PropertyArrayDto.fromJson(Map<String, dynamic> json) =>
      _$PropertyArrayDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyArrayDtoToJson(this);

  @override
  List<Object?> get props => [
        propertyId,
        propertyName,
        propertyValue,
      ];
}
