import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/prepaid_water/domain/model/prepaid_water_order_data.dart';

/// Репозиторий формирования заказа на пополнение баланса предоплатной воды.
abstract interface class IOrderWaterRepository {
  /// Отправляет запрос на создание заказа на сервере на основе предоставленной
  /// информации о заказе.
  ///
  /// Возвращает информацию о созданном заказе, необходимую для запуска
  /// токенизации платежа в ЮКасса.
  Future<Either<Failure, TokenizationData>> createOrder({
    required PaymentMethod paymentMethod,
    required OrderWaterData orderData,
  });
}
