import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/enums/orders_payment_types.dart';

class UserOrder extends Equatable {
  const UserOrder({
    required this.id,
    required this.orderNumber,
    required this.dateDelivery,
    required this.date,
    required this.timeBegin,
    required this.timeEnd,
    required this.customerName,
    required this.customerPhone,
    required this.locationId,
    required this.locationName,
    required this.description,
    required this.sumDelivery,
    required this.sumDiscont,
    required this.promoCode,
    required this.promoCodeSum,
    required this.taraCount,
    required this.taraSum,
    required this.bonusesAdd,
    required this.bonusesPay,
    required this.orderStatus,
    required this.orderProductsCount,
    required this.orderProductsSum,
    required this.totalBenefit,
    required this.totalSum,
    required this.rating,
    required this.ratingDescription,
    required this.paymentType,
    required this.paymentCompleted,
    required this.products,
  });

  final String id;
  final String orderNumber;
  final DateTime dateDelivery;
  final DateTime date;
  final DateTime timeBegin;
  final DateTime timeEnd;
  final String customerName;
  final String customerPhone;
  final String locationId;
  final String locationName;
  final String description;
  final double sumDelivery;
  final double sumDiscont;
  final String promoCode;
  final double promoCodeSum;
  final int taraCount;
  final double taraSum;
  final double bonusesAdd;
  final double bonusesPay;
  final OrderStatus orderStatus;
  final int orderProductsCount;
  final double orderProductsSum;
  final double totalBenefit;
  final double totalSum;
  final int rating;
  final String ratingDescription;
  final OrdersPaymentTypes paymentType;
  final bool paymentCompleted;
  final List<Product> products;

  @override
  List<Object?> get props => [
        id,
        dateDelivery,
        date,
        timeBegin,
        timeEnd,
        customerName,
        customerPhone,
        locationId,
        locationName,
        description,
        sumDelivery,
        sumDiscont,
        promoCode,
        promoCodeSum,
        taraCount,
        taraSum,
        bonusesAdd,
        bonusesPay,
        orderStatus,
        orderProductsCount,
        orderProductsSum,
        totalBenefit,
        totalSum,
        rating,
        ratingDescription,
        paymentType,
        paymentCompleted,
        products,
      ];
}
