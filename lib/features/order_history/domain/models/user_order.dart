// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/common/domain/models/product.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/enums/order_status.dart';
import '../../../../core/utils/enums/orders_payment_types.dart';

/// Модель заказа
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
    required this.pickup,
    required this.sumDelivery,
    required this.sumDiscont,
    required this.promoCode,
    required this.promoCodeSum,
    required this.taraCount,
    required this.taraSum,
    required this.bonusesAdd,
    required this.bonusesPay,
    required this.orderStatus,
    required this.orderStatusHex,
    required this.orderProductsCount,
    required this.orderProductsSum,
    required this.totalBenefit,
    required this.totalSum,
    required this.rating,
    required this.ratingDescription,
    required this.orderAgain,
    required this.paymentType,
    required this.paymentCompleted,
    required this.products,
  });

  /// Идентификатор заказа
  final String id;

  /// Номер заказа
  final String orderNumber;

  /// Дата доставки
  final DateTime dateDelivery;

  /// Дата заказа
  final DateTime date;

  /// Время начала доставки
  final DateTime timeBegin;

  /// Время окончания доставки
  final DateTime timeEnd;

  /// Имя клиента
  final String customerName;

  /// Телефон клиента
  final String customerPhone;

  /// Идентификатор локации
  final String locationId;

  /// Название локации
  final String locationName;

  /// Описание заказа
  final String description;

  /// Флаг, указывающий на то, что заказ будет доставлен на адрес клиента
  final bool pickup;

  /// Сумма доставки
  final double sumDelivery;

  /// Сумма скидки
  final double sumDiscont;

  /// Промокод
  final String promoCode;

  /// Сумма промокода
  final double promoCodeSum;

  /// Количество тары
  final int taraCount;

  /// Сумма тары
  final double taraSum;

  /// Бонусы добавленные
  final double bonusesAdd;

  /// Бонусы оплаченные
  final double bonusesPay;

  /// Статус заказа
  final OrderStatus orderStatus;

  /// Цвет статуса заказа
  final String orderStatusHex;

  /// Количество товаров в заказе
  final int orderProductsCount;

  /// Сумма товаров в заказе
  final double orderProductsSum;

  /// Общая выгода
  final double totalBenefit;

  /// Общая сумма
  final double totalSum;

  /// Оценка заказа
  final int rating;

  /// Описание оценки
  final String ratingDescription;

  /// Флаг, указывающий на то, что заказ можно заказать снова
  final bool orderAgain;

  /// Тип оплаты
  final OrdersPaymentTypes paymentType;

  /// Флаг, указывающий на то, что заказ оплачен
  final bool paymentCompleted;

  /// Список товаров в заказе
  final List<Product> products;

  /// Флаг, указывающий на то, что заказ отменен
  bool get isCanceled => orderStatus == OrderStatus.cancelled;

  /// Флаг, указывающий на то, что заказ активен
  bool get isActive =>
      orderStatus == OrderStatus.goingTo || orderStatus == OrderStatus.onWay;

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
        pickup,
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
        orderAgain,
        paymentType,
        paymentCompleted,
        products,
      ];
}
