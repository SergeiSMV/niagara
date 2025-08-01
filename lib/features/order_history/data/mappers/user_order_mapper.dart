import '../../../../core/common/data/mappers/product_mapper.dart';
import '../../../../core/utils/enums/order_status.dart';
import '../../../../core/utils/enums/orders_payment_types.dart';
import '../../domain/models/user_order.dart';
import '../local/entities/user_order_entity.dart';
import '../remote/dto/user_order_dto.dart';

extension UserOrderDtoMapper on UserOrderDto {
  UserOrder toModel() => UserOrder(
        id: ordersId,
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
        pickup: ordersPickup,
        sumDelivery: ordersSumDelivery,
        sumDiscont: ordersSumDiscont,
        promoCode: ordersPromoCode,
        promoCodeSum: ordersPromoCodeSum,
        taraCount: ordersTaraCount,
        taraSum: ordersTaraSum,
        bonusesAdd: ordersBonusesAdd,
        bonusesPay: ordersBonusesPay,
        orderStatus: OrderStatus.toEnum(ordersStatus),
        orderStatusHex: ordersStatusHex,
        orderProductsCount: ordersProductsCount,
        orderProductsSum: ordersProductsSum,
        totalBenefit: ordersTotalBenefit,
        totalSum: ordersTotalSum,
        rating: ordersRating,
        ratingDescription: ordersRatingDescription,
        orderAgain: ordersRepeatEnable,
        paymentType: OrdersPaymentTypes.toEnum(ordersPaymentType),
        paymentCompleted: ordersPaymentCompleted,
        products: products.map((e) => e.toModel()).toList(),
      );
}

extension UserOrderToEntity on UserOrder {
  UserOrderEntity toEntity() => UserOrderEntity(
        id: id,
        orderNumber: orderNumber,
        dateDelivery: dateDelivery,
        date: date,
        timeBegin: timeBegin,
        timeEnd: timeEnd,
        customerName: customerName,
        customerPhone: customerPhone,
        locationId: locationId,
        locationName: locationName,
        description: description,
        pickup: pickup,
        sumDelivery: sumDelivery,
        sumDiscont: sumDiscont,
        promoCode: promoCode,
        promoCodeSum: promoCodeSum,
        taraCount: taraCount,
        taraSum: taraSum,
        bonusesAdd: bonusesAdd,
        bonusesPay: bonusesPay,
        orderStatus: orderStatus,
        orderStatusHex: orderStatusHex,
        orderProductsCount: orderProductsCount,
        orderProductsSum: orderProductsSum,
        totalBenefit: totalBenefit,
        totalSum: totalSum,
        rating: rating,
        ratingDescription: ratingDescription,
        orderAgain: orderAgain,
        paymentType: paymentType,
        paymentCompleted: paymentCompleted,
        products: products.map((e) => e.toEntity()).toList(),
      );
}
