import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';

class UserOrder extends Equatable {
  const UserOrder({
    required this.ordersDateDelivery,
    required this.ordersDate,
    required this.ordersTimeBegin,
    required this.ordersTimeEnd,
    required this.ordersLocationId,
    required this.ordersLocationName,
    required this.ordersDescription,
    required this.ordersSumDelivery,
    required this.ordersSumDiscont,
    required this.ordersPromocode,
    required this.ordersPromocodeSum,
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
    required this.ordersPaymentComplited,
    required this.products,
  });
  final DateTime ordersDateDelivery;
  final DateTime ordersDate;
  final DateTime ordersTimeBegin;
  final DateTime ordersTimeEnd;
  final String ordersLocationId;
  final String ordersLocationName;
  final String ordersDescription;
  final double ordersSumDelivery;
  final double ordersSumDiscont;
  final String ordersPromocode;
  final double ordersPromocodeSum;
  final int ordersTaraCount;
  final double ordersTaraSum;
  final double ordersBonusesAdd;
  final double ordersBonusesPay;
  final OrderStatus ordersStatus;
  final int ordersProductsCount;
  final double ordersProductsSum;
  final double ordersTotalBenefit;
  final double ordersTotalSum;
  final int ordersRating;
  final String ordersRatingDescription;
  final String ordersPaymentType; //TODO
  final bool ordersPaymentComplited;
  final List<Product> products;

  // ORDERS_PAYMENT_TYPE– тип опплаты (CASH-наличными, CARD-картой курьеру, ONLINE-онлай через приложение)

  @override
  List<Object?> get props => [
        ordersDateDelivery,
        ordersDate,
        ordersTimeBegin,
        ordersTimeEnd,
        ordersLocationId,
        ordersLocationName,
        ordersDescription,
        ordersSumDelivery,
        ordersSumDiscont,
        ordersPromocode,
        ordersPromocodeSum,
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
        ordersPaymentComplited,
        products,
      ];
}
