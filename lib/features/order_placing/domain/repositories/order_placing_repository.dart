import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/delivery_time_options.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';

abstract interface class IOrderPlacingRepository {
  /// Отправляет запрос на получение списка доступных дат и временных интервалов
  /// доставки в рамках каждой даты для локации с заданым [locationId].
  Future<Either<Failure, List<DeliveryTimeOptions>>> getDeliveryTimeOptions({
    required String locationId,
  });

  /// Отправляет запрос на создание заказа на сервере. Принимает информацию о
  /// заказе [orderInfo].
  ///
  /// Возвращает информацию о созданном заказе, необходимую для запуска
  /// токенизации платежа в ЮКасса.
  Future<Either<Failure, TokenizationData>> createOrder({
    required DateTime deliveryDate,
    required TimeSlot timeSlot,
    required PaymentMethod paymentMethod,
    required String locationId,
    String? comment,
  });
}
