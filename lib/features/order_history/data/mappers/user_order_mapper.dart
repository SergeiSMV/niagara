import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/enums/orders_payment_types.dart';
import 'package:niagara_app/features/order_history/data/remote/dto/user_order_dto.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';

extension UserOrderDtoMapper on UserOrderDto {
  UserOrder toModel() {
    return UserOrder(
      orderNumber: ordersNumber,
      dateDelivery: ordersDateDelivery,
      date: ordersDate,
      timeBegin: ordersTimeBegin,
      timeEnd: ordersTimeEnd,
      customerName: ordersCustomerName,
      customerPhone: ordersCustomerPhone,
      locationId: ordersLocationId,
      locationName: ordersLocationName,
      description: ordersDescription,
      sumDelivery: ordersSumDelivery,
      sumDiscont: ordersSumDiscont,
      promoCode: ordersPromoCode,
      promoCodeSum: ordersPromoCodeSum,
      taraCount: ordersTaraCount,
      taraSum: ordersTaraSum,
      bonusesAdd: ordersBonusesAdd,
      bonusesPay: ordersBonusesPay,
      orderStatus: OrderStatus.toEnum(ordersStatus),
      orderProductsCount: ordersProductsCount,
      orderProductsSum: ordersProductsSum,
      totalBenefit: ordersTotalBenefit,
      totalSum: ordersTotalSum,
      rating: ordersRating,
      ratingDescription: ordersRatingDescription,
      paymentType: OrdersPaymentTypes.toEnum(ordersPaymentType),
      paymentCompleted: ordersPaymentCompleted,
      products: products.map((e) => e.toModel()).toList(),
    );
  }
}
