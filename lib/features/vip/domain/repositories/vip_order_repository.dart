import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';

/// Репозиторий формирования заказа VIP-подписки.
abstract interface class IVipOrderRepository {
  /// Отправляет запрос на создание заказа на сервере на основе предоставленной
  /// информации о заказе.
  ///
  /// Возвращает информацию о созданном заказе, необходимую для запуска
  /// токенизации платежа в ЮКасса.
  Future<Either<Failure, TokenizationData>> createOrder({
    required PaymentMethod paymentMethod,
    required ActivationOption activationOption,
  });
}
