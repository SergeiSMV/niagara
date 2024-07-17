import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';

part 'user_order_dto.g.dart';

typedef OrdersDto = ({List<UserOrderDto> orders, PaginationDto pagination});

@JsonSerializable(createToJson: false)
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
    required this.ordersSumDelivery,
    required this.ordersSumDiscont,
    required this.ordersPromoCode,
    required this.ordersPromoCodeSum,
    required this.ordersTaraCount,
    required this.ordersTaraSum,
    required this.ordersBonusesAdd,
    required this.ordersBonusesPay,
    required this.ordersStatus,
    required this.ordersProductsCount,
    required this.ordersProductsSum,
    required this.ordersTotalBenefit,
    required this.ordersTotalSum,
    required this.ordersRating,
    required this.ordersRatingDescription,
    required this.ordersPaymentType,
    required this.ordersPaymentCompleted,
    required this.products,
  });

  factory UserOrderDto.fromJson(Map<String, dynamic> json) =>
      _$UserOrderDtoFromJson(json);

  @JsonKey(name: 'ORDERS_ID')
  final String ordersId;
  @JsonKey(name: 'ORDERS_NUMBER')
  final String ordersNumber;
  @JsonKey(name: 'ORDERS_DATE_DELIVERY')
  final DateTime ordersDateDelivery;
  @JsonKey(name: 'ORDERS_DATE')
  final DateTime ordersDate;
  @JsonKey(name: 'ORDERS_TIME_BEGIN')
  final DateTime ordersTimeBegin;
  @JsonKey(name: 'ORDERS_TIME_END')
  final DateTime ordersTimeEnd;
  @JsonKey(name: 'ORDERS_CUSTOMER_NAME')
  final String ordersCustomerName;
  @JsonKey(name: 'ORDERS_CUSTOMER_PHONE')
  final String ordersCustomerPhone;
  @JsonKey(name: 'ORDERS_LOCATION_ID')
  final String ordersLocationId;
  @JsonKey(name: 'ORDERS_LOCATION_NAME')
  final String ordersLocationName;
  @JsonKey(name: 'ORDERS_DESCRIPTION')
  final String ordersDescription;
  @JsonKey(name: 'ORDERS_SUM_DELIVERY')
  final double ordersSumDelivery;
  @JsonKey(name: 'ORDERS_SUM_DISCONT')
  final double ordersSumDiscont;
  @JsonKey(name: 'ORDERS_PROMOCODE')
  final String ordersPromoCode;
  @JsonKey(name: 'ORDERS_PROMOCODE_SUM')
  final double ordersPromoCodeSum;
  @JsonKey(name: 'ORDERS_TARA_COUNT')
  final int ordersTaraCount;
  @JsonKey(name: 'ORDERS_TARA_SUM')
  final double ordersTaraSum;
  @JsonKey(name: 'ORDERS_BONUSES_ADD')
  final double ordersBonusesAdd;
  @JsonKey(name: 'ORDERS_BONUSES_PAY')
  final double ordersBonusesPay;
  @JsonKey(name: 'ORDERS_STATUS')
  final String ordersStatus;
  @JsonKey(name: 'ORDERS_PRODUCTS_COUNT')
  final int ordersProductsCount;
  @JsonKey(name: 'ORDERS_PRODUCTS_SUM')
  final double ordersProductsSum;
  @JsonKey(name: 'ORDERS_TOTAL_BENEFIT')
  final double ordersTotalBenefit;
  @JsonKey(name: 'ORDERS_TOTAL_SUM')
  final double ordersTotalSum;
  @JsonKey(name: 'ORDERS_RATING')
  final int ordersRating;
  @JsonKey(name: 'ORDERS_RATING_DESCRIPTION')
  final String ordersRatingDescription;
  @JsonKey(name: 'ORDERS_PAYMENT_TYPE')
  final String ordersPaymentType;
  @JsonKey(name: 'ORDERS_PAYMENT_COMPLITED')
  final bool ordersPaymentCompleted;
  @JsonKey(name: 'PRODUCTS')
  final List<ProductDto> products;

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
        ordersPaymentType,
        ordersPaymentCompleted,
        products,
      ];
}
