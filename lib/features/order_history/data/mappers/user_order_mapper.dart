import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/features/order_history/data/remote/dto/user_order_dto.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';

extension UserOrderDtoMapper on UserOrderDto {
  UserOrder toModel() {
    return UserOrder(
      ordersDateDelivery: ordersDateDelivery,
      ordersDate: ordersDate,
      ordersTimeBegin: ordersTimeBegin,
      ordersTimeEnd: ordersTimeEnd,
      ordersLocationId: ordersLocationId,
      ordersLocationName: ordersLocationName,
      ordersDescription: ordersDescription,
      ordersSumDelivery: ordersSumDelivery,
      ordersSumDiscont: ordersSumDiscont,
      ordersPromocode: ordersPromocode,
      ordersPromocodeSum: ordersPromocodeSum,
      ordersTaraCount: ordersTaraCount,
      ordersTaraSum: ordersTaraSum,
      ordersBonusesAdd: ordersBonusesAdd,
      ordersBonusesPay: ordersBonusesPay,
      ordersStatus: ordersStatus,
      ordersProductsCount: ordersProductsCount,
      ordersProductsSum: ordersProductsSum,
      ordersTotalBenefit: ordersTotalBenefit,
      ordersTotalSum: ordersTotalSum,
      ordersRating: ordersRating,
      ordersRatingDescription: ordersRatingDescription,
      ordersPaymentType: ordersPaymentType,
      ordersPaymentComplited: ordersPaymentComplited,
      products: products.map((e) => e.toModel()).toList(),
    );
  }
}
