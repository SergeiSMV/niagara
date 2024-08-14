// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';

part 'cart_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class CartDto extends Equatable {
  const CartDto({
    required this.products,
    required this.outOfStock,
    required this.data,
    required this.sumLimit,
    required this.locationId,
    required this.locationName,
  });

  final List<ProductDto> products;
  final List<ProductDto> outOfStock;
  final CartDataDto data;
  final CartSumLimitDto sumLimit;
  final String? locationId;
  final String? locationName;

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  @override
  List<Object?> get props => [
        products,
        outOfStock,
        data,
        sumLimit,
        locationId,
        locationName,
      ];
}

@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class CartDataDto extends Equatable {
  const CartDataDto({
    this.sumDelivery,
    this.sumDiscont,
    this.sumPromocode,
    this.countTara,
    this.sumTara,
    this.bonuses,
    this.bonusesPay,
    this.bonusesAdd,
    this.totalBenefit,
    this.totalSum,
    this.totalSumFull,
    this.totalSumVip,
  });

  final double? sumDelivery;
  final double? sumDiscont;
  final double? sumPromocode;
  final double? countTara;
  final double? sumTara;
  final double? bonuses;
  final double? bonusesPay;
  final double? bonusesAdd;
  final double? totalBenefit;
  final double? totalSum;
  final double? totalSumFull;
  final double? totalSumVip;

  factory CartDataDto.fromJson(Map<String, dynamic> json) =>
      _$CartDataDtoFromJson(json);

  @override
  List<Object?> get props => [
        sumDelivery,
        sumDiscont,
        sumPromocode,
        countTara,
        sumTara,
        bonuses,
        bonusesPay,
        bonusesAdd,
        totalBenefit,
        totalSum,
        totalSumFull,
        totalSumVip,
      ];
}

@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class CartSumLimitDto extends Equatable {
  const CartSumLimitDto({
    this.sumMin,
    this.sumRemain,
  });

  final double? sumMin;
  final double? sumRemain;

  factory CartSumLimitDto.fromJson(Map<String, dynamic> json) =>
      _$CartSumLimitDtoFromJson(json);

  @override
  List<Object?> get props => [sumMin, sumRemain];
}
