import 'package:equatable/equatable.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';

class Cart extends Equatable {
  const Cart({
    required this.products,
    required this.unavailableProducts,
    required this.cartData,
    required this.minLimit,
  });

  final List<Product> products;
  final List<Product> unavailableProducts;
  final CartData cartData;
  final CartMinAmount minLimit;

  bool get isEmpty => products.isEmpty && unavailableProducts.isEmpty;

  @override
  List<Object?> get props => [
        products,
        unavailableProducts,
        cartData,
        minLimit,
      ];
}

class CartData extends Equatable {
  const CartData({
    required this.deliveryFee,
    required this.discount,
    required this.promocode,
    required this.tareCount,
    required this.tareDiscount,
    required this.bonuses,
    required this.bonusesPayment,
    required this.bonusesAccumulation,
    required this.benefits,
    required this.totalPrice,
    required this.fullPrice,
    required this.vipPrice,
  });

  final double deliveryFee;
  final double discount;
  final double promocode;
  final int tareCount;
  final double tareDiscount;
  final double bonuses;
  final double bonusesPayment;
  final double bonusesAccumulation;
  final double benefits;
  final double totalPrice;
  final double fullPrice;
  final double vipPrice;

  @override
  List<Object?> get props => [
        deliveryFee,
        discount,
        promocode,
        tareCount,
        tareDiscount,
        bonuses,
        bonusesPayment,
        bonusesAccumulation,
        benefits,
        totalPrice,
        fullPrice,
        vipPrice,
      ];
}

class CartMinAmount extends Equatable {
  const CartMinAmount({
    required this.minAmount,
    required this.minAmountLeft,
  });

  final double minAmount;
  final double minAmountLeft;

  bool get readyToOrder => minAmountLeft >= minAmount;

  @override
  List<Object?> get props => [
        minAmount,
        minAmountLeft,
      ];
}
