// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  UserOrder copyWith({
    String? id,
    String? orderNumber,
    DateTime? dateDelivery,
    DateTime? date,
    DateTime? timeBegin,
    DateTime? timeEnd,
    String? customerName,
    String? customerPhone,
    String? locationId,
    String? locationName,
    String? description,
    double? sumDelivery,
    double? sumDiscont,
    String? promoCode,
    double? promoCodeSum,
    int? taraCount,
    double? taraSum,
    double? bonusesAdd,
    double? bonusesPay,
    OrderStatus? orderStatus,
    int? orderProductsCount,
    double? orderProductsSum,
    double? totalBenefit,
    double? totalSum,
    int? rating,
    String? ratingDescription,
    OrdersPaymentTypes? paymentType,
    bool? paymentCompleted,
    List<Product>? products,
  }) {
    return UserOrder(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      dateDelivery: dateDelivery ?? this.dateDelivery,
      date: date ?? this.date,
      timeBegin: timeBegin ?? this.timeBegin,
      timeEnd: timeEnd ?? this.timeEnd,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      locationId: locationId ?? this.locationId,
      locationName: locationName ?? this.locationName,
      description: description ?? this.description,
      sumDelivery: sumDelivery ?? this.sumDelivery,
      sumDiscont: sumDiscont ?? this.sumDiscont,
      promoCode: promoCode ?? this.promoCode,
      promoCodeSum: promoCodeSum ?? this.promoCodeSum,
      taraCount: taraCount ?? this.taraCount,
      taraSum: taraSum ?? this.taraSum,
      bonusesAdd: bonusesAdd ?? this.bonusesAdd,
      bonusesPay: bonusesPay ?? this.bonusesPay,
      orderStatus: orderStatus ?? this.orderStatus,
      orderProductsCount: orderProductsCount ?? this.orderProductsCount,
      orderProductsSum: orderProductsSum ?? this.orderProductsSum,
      totalBenefit: totalBenefit ?? this.totalBenefit,
      totalSum: totalSum ?? this.totalSum,
      rating: rating ?? this.rating,
      ratingDescription: ratingDescription ?? this.ratingDescription,
      paymentType: paymentType ?? this.paymentType,
      paymentCompleted: paymentCompleted ?? this.paymentCompleted,
      products: products ?? this.products,
    );
  }
}
