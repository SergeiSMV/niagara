// ignore_for_file: sort_constructors_first

import '../../../../../core/common/data/remote/dto/pagination_dto.dart';
import '../../../../../core/common/data/remote/dto/product_dto.dart';
import '../../../../../core/core.dart';

typedef OrdersDto = ({List<UserOrderDto> orders, PaginationDto pagination});

class UserOrderDto extends Equatable {
  const UserOrderDto({
    required this.ordersId,
    required this.ordersNumber,
    required this.ordersDateDelivery,
    required this.ordersDate,
    required this.ordersTimeBegin,
    required this.ordersTimeEnd,
    required this.ordersCustomerName,
    required this.ordersCustomerPhone,
    required this.ordersLocationId,
    required this.ordersLocationName,
    required this.ordersDescription,
    required this.ordersPickup,
    required this.ordersSumDelivery,
    required this.ordersSumDiscont,
    required this.ordersPromoCode,
    required this.ordersPromoCodeSum,
    required this.ordersTaraCount,
    required this.ordersTaraSum,
    required this.ordersBonusesAdd,
    required this.ordersBonusesPay,
    required this.ordersStatus,
    required this.ordersStatusHex,
    required this.ordersProductsCount,
    required this.ordersProductsSum,
    required this.ordersTotalBenefit,
    required this.ordersTotalSum,
    required this.ordersRating,
    required this.ordersRatingDescription,
    required this.ordersRepeatEnable,
    required this.ordersPaymentType,
    required this.ordersPaymentCompleted,
    required this.products,
  });

  final String ordersId;
  final String ordersNumber;
  final DateTime ordersDateDelivery;
  final DateTime ordersDate;
  final DateTime ordersTimeBegin;
  final DateTime ordersTimeEnd;
  final String ordersCustomerName;
  final String ordersCustomerPhone;
  final String ordersLocationId;
  final String ordersLocationName;
  final String ordersDescription;
  final bool ordersPickup;
  final double ordersSumDelivery;
  final double ordersSumDiscont;
  final String ordersPromoCode;
  final double ordersPromoCodeSum;
  final int ordersTaraCount;
  final double ordersTaraSum;
  final double ordersBonusesAdd;
  final double ordersBonusesPay;
  final String ordersStatus;
  final String ordersStatusHex;
  final int ordersProductsCount;
  final double ordersProductsSum;
  final double ordersTotalBenefit;
  final double ordersTotalSum;
  final int ordersRating;
  final String ordersRatingDescription;
  final bool ordersRepeatEnable;
  final String ordersPaymentType;
  final bool ordersPaymentCompleted;
  final List<ProductDto> products;

  factory UserOrderDto.fromJson(Map<String, dynamic> json) => UserOrderDto(
        ordersId: json['ORDERS_ID'] as String,
        ordersNumber: json['ORDERS_NUMBER'] as String,
        ordersDateDelivery:
            DateTime.parse(json['ORDERS_DATE_DELIVERY'] as String),
        ordersDate: DateTime.parse(json['ORDERS_DATE'] as String),
        ordersTimeBegin: DateTime.parse(json['ORDERS_TIME_BEGIN'] as String),
        ordersTimeEnd: DateTime.parse(json['ORDERS_TIME_END'] as String),
        ordersCustomerName: (json['ORDERS_CUSTOMER_NAME'] ?? '') as String,
        ordersCustomerPhone: (json['ORDERS_CUSTOMER_PHONE'] ?? '') as String,
        ordersLocationId: (json['ORDERS_LOCATION_ID'] ?? '') as String,
        ordersLocationName: (json['ORDERS_LOCATION_NAME'] ?? '') as String,
        ordersDescription: (json['ORDERS_DESCRIPTION'] ?? '') as String,
        ordersPickup: json['ORDERS_PICKUP'] as bool,
        ordersSumDelivery: (json['ORDERS_SUM_DELIVERY'] as num).toDouble(),
        ordersSumDiscont: (json['ORDERS_SUM_DISCONT'] as num).toDouble(),
        ordersPromoCode: json['ORDERS_PROMOCODE'] as String,
        ordersPromoCodeSum: (json['ORDERS_PROMOCODE_SUM'] as num).toDouble(),
        ordersTaraCount: (json['ORDERS_TARA_COUNT'] as num).toInt(),
        ordersTaraSum: (json['ORDERS_TARA_SUM'] as num).toDouble(),
        ordersBonusesAdd: (json['ORDERS_BONUSES_ADD'] as num).toDouble(),
        ordersBonusesPay: (json['ORDERS_BONUSES_PAY'] as num).toDouble(),
        ordersStatus: json['ORDERS_STATUS'] as String,
        ordersStatusHex: json['ORDERS_STATUS_COLOR'] as String,
        ordersProductsCount: (json['ORDERS_PRODUCTS_COUNT'] as num).toInt(),
        ordersProductsSum: (json['ORDERS_PRODUCTS_SUM'] as num).toDouble(),
        ordersTotalBenefit: (json['ORDERS_TOTAL_BENEFIT'] as num).toDouble(),
        ordersTotalSum: (json['ORDERS_TOTAL_SUM'] as num).toDouble(),
        ordersRating: (json['ORDERS_RATING'] as num).toInt(),
        ordersRatingDescription: json['ORDERS_RATING_DESCRIPTION'] as String,
        ordersRepeatEnable: json['ORDERS_REPEAT_ENABLE'] as bool,
        ordersPaymentType: json['ORDERS_PAYMENT_TYPE'] as String,
        ordersPaymentCompleted: json['ORDERS_PAYMENT_COMPLITED'] as bool,
        products: (json['PRODUCTS'] as List<dynamic>)
            .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [
        ordersId,
        ordersDateDelivery,
        ordersDate,
        ordersTimeBegin,
        ordersTimeEnd,
        ordersCustomerName,
        ordersCustomerPhone,
        ordersLocationId,
        ordersLocationName,
        ordersDescription,
        ordersPickup,
        ordersSumDelivery,
        ordersSumDiscont,
        ordersPromoCode,
        ordersPromoCodeSum,
        ordersTaraCount,
        ordersTaraSum,
        ordersBonusesAdd,
        ordersBonusesPay,
        ordersStatus,
        ordersProductsCount,
        ordersProductsSum,
        ordersTotalBenefit,
        ordersTotalSum,
        ordersRating,
        ordersRatingDescription,
        ordersRepeatEnable,
        ordersPaymentType,
        ordersPaymentCompleted,
        products,
      ];
}
