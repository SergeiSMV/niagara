// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';

class CartDto extends Equatable {
  const CartDto({
    required this.products,
    required this.outOfStock,
    required this.recommends,
    required this.data,
    required this.sumLimit,
    required this.paymentMethod,
  });

  final List<ProductDto> products;
  final List<ProductDto> outOfStock;
  final List<ProductDto> recommends;
  final CartDataDto data;
  final CartSumLimitDto sumLimit;
  final List<PaymentMethodDto> paymentMethod;

  factory CartDto.fromJson(Map<String, dynamic> json) => CartDto(
        products: (json['PRODUCTS'] as List<dynamic>)
            .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        outOfStock: (json['OUT_OF_STOCK'] as List<dynamic>)
            .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        recommends: (json['RECOMMEND'] as List<dynamic>)
            .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        data: CartDataDto.fromJson(json['DATA'] as Map<String, dynamic>),
        sumLimit:
            CartSumLimitDto.fromJson(json['SUM_LIMIT'] as Map<String, dynamic>),
        paymentMethod: (json['PAYMENT_METHOD'] as List<dynamic>)
            .map((e) => PaymentMethodDto.fromString(e as String))
            .toList(),
      );

  @override
  List<Object?> get props => [
        products,
        outOfStock,
        data,
        sumLimit,
      ];
}

enum PaymentMethodDto {
  cash,
  bankCard,
  sbp,
  sberbank;

  static PaymentMethodDto fromString(String value) {
    switch (value) {
      case 'bank_card':
        return PaymentMethodDto.bankCard;
      case 'sbp':
        return PaymentMethodDto.sbp;
      case 'sberbank':
        return PaymentMethodDto.sberbank;
      case 'terminal':
      case 'cash':
        return PaymentMethodDto.cash;

      default:
        throw ArgumentError('Unknown PaymentMethodDto: $value');
    }
  }
}

class CartDataDto extends Equatable {
  const CartDataDto({
    this.sumDelivery,
    this.sumDiscont,
    this.sumPromocode,
    this.countTara,
    this.countTaraOther,
    this.sumTara,
    this.sumTaraOther,
    this.countTaraDefault,
    this.taraNotation,
    this.bonuses,
    this.bonusesPay,
    this.bonusesAdd,
    this.totalBenefit,
    this.totalSum,
    this.totalSumFull,
    this.totalSumVip,
    this.productsSum,
    this.productsCount,
    required this.location,
    required this.locationName,
  });

  final double? sumDelivery;
  final double? sumDiscont;
  final double? sumPromocode;
  final double? productsSum;
  final double? productsCount;
  final double? countTara;
  final double? countTaraOther;
  final double? sumTara;
  final double? sumTaraOther;
  final double? countTaraDefault;
  final String? taraNotation;
  final double? bonuses;
  final double? bonusesPay;
  final double? bonusesAdd;
  final double? totalBenefit;
  final double? totalSum;
  final double? totalSumFull;
  final double? totalSumVip;
  final String location;
  final String locationName;

  factory CartDataDto.fromJson(Map<String, dynamic> json) => CartDataDto(
        sumDelivery: (json['SUM_DELIVERY'] as num?)?.toDouble(),
        sumDiscont: (json['SUM_DISCONT'] as num?)?.toDouble(),
        sumPromocode: (json['SUM_PROMOCODE'] as num?)?.toDouble(),
        productsSum: (json['PRODUCTS_SUM'] as num?)?.toDouble(),
        productsCount: (json['PRODUCTS_COUNT'] as num?)?.toDouble(),
        countTara: (json['COUNT_TARA'] as num?)?.toDouble(),
        countTaraOther: (json['COUNT_TARA_OTHER'] as num?)?.toDouble(),
        countTaraDefault: (json['COUNT_TARA_DEFAULT'] as num?)?.toDouble(),
        sumTara: (json['SUM_TARA'] as num?)?.toDouble(),
        sumTaraOther: (json['SUM_TARA_OTHER'] as num?)?.toDouble(),
        taraNotation: json['TARA_NOTATION'] as String,
        bonuses: (json['BONUSES'] as num?)?.toDouble(),
        bonusesPay: (json['BONUSES_PAY'] as num?)?.toDouble(),
        bonusesAdd: (json['BONUSES_ADD'] as num?)?.toDouble(),
        totalBenefit: (json['TOTAL_BENEFIT'] as num?)?.toDouble(),
        totalSum: (json['TOTAL_SUM'] as num?)?.toDouble(),
        totalSumFull: (json['TOTAL_SUM_FULL'] as num?)?.toDouble(),
        totalSumVip: (json['TOTAL_SUM_VIP'] as num?)?.toDouble(),
        location: json['LOCATION'] as String,
        locationName: json['LOCATION_NAME'] as String,
      );

  @override
  List<Object?> get props => [
        sumDelivery,
        sumDiscont,
        sumPromocode,
        countTara,
        countTaraOther,
        sumTara,
        bonuses,
        bonusesPay,
        bonusesAdd,
        totalBenefit,
        totalSum,
        totalSumFull,
        totalSumVip,
        location,
        locationName,
      ];
}

class CartSumLimitDto extends Equatable {
  const CartSumLimitDto({
    this.sumMin,
    this.sumRemain,
  });

  final double? sumMin;
  final double? sumRemain;

  factory CartSumLimitDto.fromJson(Map<String, dynamic> json) =>
      CartSumLimitDto(
        sumMin: (json['SUM_MIN'] as num?)?.toDouble(),
        sumRemain: (json['SUM_REMAIN'] as num?)?.toDouble(),
      );

  @override
  List<Object?> get props => [sumMin, sumRemain];
}
