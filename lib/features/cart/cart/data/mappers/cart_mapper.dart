import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/features/cart/cart/data/remote/cart_dto.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

extension CartDtoMapper on CartDto {
  Cart toModel() => Cart(
        products: products.map((e) => e.toModel()).toList(),
        unavailableProducts: outOfStock.map((e) => e.toModel()).toList(),
        cartData: data.toModel(),
        minLimit: sumLimit?.toModel(),
      );
}

extension CartDataMapper on CartDataDto {
  CartData toModel() => CartData(
        deliveryFee: sumDelivery ?? 0,
        discount: sumDiscont ?? 0,
        promocode: sumPromocode ?? 0,
        tareCount: countTara?.toInt() ?? 0,
        tareDiscount: sumTara ?? 0,
        bonuses: bonuses ?? 0,
        bonusesPayment: bonusesPay ?? 0,
        bonusesAccumulation: bonusesAdd ?? 0,
        benefits: totalBenefit ?? 0,
        totalPrice: totalSum ?? 0,
        fullPrice: totalSumFull ?? 0,
        vipPrice: totalSumVip ?? 0,
      );
}

extension CartMinAmountMapper on CartSumLimitDto {
  CartMinAmount toModel() => CartMinAmount(
        minAmount: sumMin ?? 0,
        minAmountLeft: sumRemain ?? 0,
      );
}
