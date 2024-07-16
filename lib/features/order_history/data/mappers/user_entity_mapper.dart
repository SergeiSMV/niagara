import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/order_history/data/local/entities/user_order_entity.dart';

extension AddressEntityMapper on UserOrderEntity {
  UserOrdersTableCompanion toCompanion() => UserOrdersTableCompanion(
        orderNumber: Value(orderNumber),
        dateDelivery: Value(dateDelivery),
        date: Value(date),
        timeBegin: Value(timeBegin),
        timeEnd: Value(timeEnd),
        customerName: Value(customerName),
        customerPhone: Value(customerPhone),
        locationId: Value(locationId),
        locationName: Value(locationName),
        description: Value(description),
        sumDelivery: Value(sumDelivery),
        sumDiscont: Value(sumDiscont),
        promoCode: Value(promoCode),
        promoCodeSum: Value(promoCodeSum),
        taraCount: Value(taraCount),
        taraSum: Value(taraSum),
        bonusesAdd: Value(bonusesAdd),
        bonusesPay: Value(bonusesPay),
        orderStatus: Value(orderStatus),
        orderProductsCount: Value(orderProductsCount),
        orderProductsSum: Value(orderProductsSum),
        totalBenefit: Value(totalBenefit),
        totalSum: Value(totalSum),
        rating: Value(rating),
        ratingDescription: Value(ratingDescription),
        paymentType: Value(paymentType),
        paymentCompleted: Value(paymentCompleted),
        products: Value(products),
      );
}

extension UserOrdersTableExtension on UserOrdersTableData {
  UserOrderEntity toEntity() => UserOrderEntity(
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
        sumDelivery: sumDelivery,
        sumDiscont: sumDiscont,
        promoCode: promoCode,
        promoCodeSum: promoCodeSum,
        taraCount: taraCount,
        taraSum: taraSum,
        bonusesAdd: bonusesAdd,
        bonusesPay: bonusesPay,
        orderStatus: orderStatus,
        orderProductsCount: orderProductsCount,
        orderProductsSum: orderProductsSum,
        totalBenefit: totalBenefit,
        totalSum: totalSum,
        rating: rating,
        ratingDescription: ratingDescription,
        paymentType: paymentType,
        paymentCompleted: paymentCompleted,
        products: products,
      );
}
