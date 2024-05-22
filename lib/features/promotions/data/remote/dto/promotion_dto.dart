// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'promotion_dto.g.dart';

@JsonSerializable(createToJson: false)
class PromotionDto extends Equatable {
  const PromotionDto({
    this.offersId,
    this.offersName,
    this.offersDescription,
    this.offersProductId,
    this.offersPrice,
    this.offersType,
    this.offersImage,
    this.offersDateBegin,
    this.offersDateEnd,
    this.offersOneTrade,
    this.offersColorFill,
    this.offersColorText,
    this.offersHashtag,
    this.offersTaraChoice,
    this.offersStructureProduct,
    this.offersDiscountProduct,
  });

  @JsonKey(name: 'OFFERS_ID')
  final String? offersId;
  @JsonKey(name: 'OFFERS_NAME')
  final String? offersName;
  @JsonKey(name: 'OFFERS_DESCRIPTION')
  final String? offersDescription;
  @JsonKey(name: 'OFFERS_PRODUCT_ID')
  final String? offersProductId;
  @JsonKey(name: 'OFFERS_PRICE')
  final int? offersPrice;
  @JsonKey(name: 'OFFERS_TYPE')
  final String? offersType;
  @JsonKey(name: 'OFFERS_IMAGE')
  final String? offersImage;
  @JsonKey(name: 'OFFERS_DATE_BEGIN')
  final String? offersDateBegin;
  @JsonKey(name: 'OFFERS_DATE_END')
  final String? offersDateEnd;
  @JsonKey(name: 'OFFERS_ONE_TRADE')
  final bool? offersOneTrade;
  @JsonKey(name: 'OFFERS_COLOR_FILL')
  final String? offersColorFill;
  @JsonKey(name: 'OFFERS_COLOR_TEXT')
  final String? offersColorText;
  @JsonKey(name: 'OFFERS_HASHTAG')
  final String? offersHashtag;
  @JsonKey(name: 'OFFERS_TARA_CHOICE')
  final bool? offersTaraChoice;
  @JsonKey(name: 'OFFERS_STRUCTURE_PRODUCT')
  final List<OffersStructureProduct>? offersStructureProduct;
  @JsonKey(name: 'OFFERS_DISCOUNT_PRODUCT')
  final List<dynamic>? offersDiscountProduct;

  factory PromotionDto.fromJson(Map<String, dynamic> json) =>
      _$PromotionDtoFromJson(json);

  @override
  List<Object?> get props => [
        offersId,
        offersName,
        offersDescription,
        offersProductId,
        offersPrice,
        offersType,
        offersImage,
        offersDateBegin,
        offersDateEnd,
        offersOneTrade,
        offersColorFill,
        offersColorText,
        offersHashtag,
        offersTaraChoice,
        offersStructureProduct,
        offersDiscountProduct,
      ];
}

@JsonSerializable(createToJson: false)
class OffersStructureProduct extends Equatable {
  const OffersStructureProduct({
    required this.productId,
    required this.count,
    required this.limit,
  });

  @JsonKey(name: 'PRODUCT_ID')
  final String productId;
  @JsonKey(name: 'COUNT')
  final int count;
  @JsonKey(name: 'LIMIT')
  final int limit;

  factory OffersStructureProduct.fromJson(Map<String, dynamic> json) =>
      _$OffersStructureProductFromJson(json);

  @override
  List<Object?> get props => [
        productId,
        count,
        limit,
      ];
}
