// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';

part 'cart_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class CartDto extends Equatable {
  const CartDto({
    required this.products,
    required this.outOfStock,
    required this.data,
    this.sumLimit,
  });

  final List<ProductDto> products;
  final List<ProductDto> outOfStock;
  final CartDataDto data;
  final CartSumLimitDto? sumLimit;

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);

  @override
  List<Object?> get props => [products, outOfStock, data, sumLimit];
}

@JsonSerializable(fieldRename: FieldRename.screamingSnake)
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

  Map<String, dynamic> toJson() => _$CartDataDtoToJson(this);

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

@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class CartSumLimitDto extends Equatable {
  const CartSumLimitDto({
    this.sumMin,
    this.sumRemain,
  });

  final double? sumMin;
  final double? sumRemain;

  factory CartSumLimitDto.fromJson(Map<String, dynamic> json) =>
      _$CartSumLimitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartSumLimitDtoToJson(this);

  @override
  List<Object?> get props => [sumMin, sumRemain];
}
