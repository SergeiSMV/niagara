import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';

class Cart extends Equatable {
  const Cart({
    required this.products,
    required this.unavailableProducts,
    required this.recommends,
    required this.cartData,
    required this.minLimit,
    required this.locationId,
    required this.locationName,
    required this.paymentMethods,
  });

  final List<Product> products;
  final List<Product> unavailableProducts;
  final List<Product> recommends;
  final CartData cartData;
  final CartMinAmount minLimit;
  final String locationId;
  final String locationName;
  final List<PaymentMethod> paymentMethods;

  /// Возвращает количество [product] среди доступных товаров в корзине.
  ///
  /// [ignoreComplect] позволяет не учитывать [Product.complectId] при поиске.
  int countInStock(Product product, {bool ignoreComplect = true}) =>
      products
          .firstWhereOrNull(
            (p) =>
                p.id == product.id &&
                (ignoreComplect || p.complectId == product.complectId),
          )
          ?.count ??
      0;

  /// Возвращает цену [product] среди доступных товаров в корзине.
  ///
  /// [ignoreComplect] позволяет не учитывать [Product.complectId] при поиске.
  int? priceInStock(Product product, {bool ignoreComplect = true}) => products
      .firstWhereOrNull(
        (p) =>
            p.id == product.id &&
            (ignoreComplect || p.complectId == product.complectId),
      )
      ?.price;

  /// Возвращает цену [product] среди доступных товаров в корзине.
  int? vipPriceInStock(Product product, {bool ignoreComplect = true}) =>
      products
          .firstWhereOrNull(
            (p) =>
                p.id == product.id &&
                (ignoreComplect || p.complectId == product.complectId),
          )
          ?.priceVip;

  /// Индикатор того, что корзина пуста.
  bool get isEmpty => products.isEmpty && unavailableProducts.isEmpty;

  /// Индикатор того, что корзина содержит предоплатную воду на списание с баланса.
  bool get containsComplect => products.any(
        (p) => p.complectId != null && p.price == 0,
      );

  @override
  List<Object?> get props => [
        products,
        unavailableProducts,
        recommends,
        cartData,
        minLimit,
        locationId,
        locationName,
        paymentMethods,
      ];
}

class CartData extends Equatable {
  const CartData({
    required this.deliveryFee,
    required this.discount,
    required this.promocode,
    required this.tareCount,
    required this.otherTareCount,
    required this.tareSum,
    required this.otherTareSum,
    required this.bonuses,
    required this.bonusesPayment,
    required this.bonusesAccumulation,
    required this.benefits,
    required this.totalPrice,
    required this.fullPrice,
    required this.vipPrice,
    required this.productsCount,
    required this.productsTotalSum,
    required this.totalTares,
    required this.taraNotation,
    required this.taraExchangeInfo,
    required this.taraProductInfo,
  });

  final double deliveryFee;
  final double discount;
  final double promocode;
  final int tareCount;
  final int otherTareCount;
  final int totalTares;
  final int productsCount;
  final int productsTotalSum;
  final int tareSum;
  final int otherTareSum;
  final double bonuses;
  final double bonusesPayment;
  final double bonusesAccumulation;
  final double benefits;
  final double totalPrice;
  final double fullPrice;
  final double vipPrice;
  final String taraNotation;
  final String taraExchangeInfo;
  final String taraProductInfo;

  @override
  List<Object?> get props => [
        deliveryFee,
        discount,
        promocode,
        tareCount,
        otherTareCount,
        tareSum,
        otherTareSum,
        bonuses,
        bonusesPayment,
        bonusesAccumulation,
        benefits,
        totalPrice,
        fullPrice,
        vipPrice,
        taraNotation,
        taraExchangeInfo,
        taraProductInfo,
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
