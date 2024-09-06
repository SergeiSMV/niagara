import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';

/// Информация о заказе, необходимая для форирования платёжного токена в ЮКасса.
class TokenizationData extends Equatable {
  const TokenizationData({
    required this.orderId,
    required this.shopId,
    required this.applicationKey,
    required this.title,
    required this.description,
    required this.customerId,
    required this.price,
    required this.paymentMethod,
  });

  /// `ID` заказа.
  final String orderId;

  /// `ID` магазина в ЮКасса.
  final String shopId;

  /// Ключ приложения в ЮКасса.
  final String applicationKey;

  /// Название заказа.
  final String title;

  /// Описание заказа.
  final String description;

  /// `ID` покупателя.
  ///
  /// Используется нативным виджетом ЮКассы для идентификации покупателя. По
  /// этому `ID` ЮКасса связывает платёж с покупателем и предлагает ему ранее
  /// сохранённые карты / методы оплаты.
  final String customerId;

  /// Сумма заказа.
  ///
  /// Отображается в нативном виджете ЮКассы.
  final String price;

  /// Выбранный метод оплаты.
  final PaymentMethod paymentMethod;

  @override
  List<Object?> get props => [
        orderId,
        shopId,
        applicationKey,
        title,
        description,
        customerId,
      ];
}
