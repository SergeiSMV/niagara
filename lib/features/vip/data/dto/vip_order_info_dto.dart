import 'package:niagara_app/core/core.dart';

/// DTO для передачи информации о заказе на активацию VIP-подписки на сервер.
class VipOrderInfoDto extends Equatable {
  const VipOrderInfoDto({
    required this.paymentMethod,
    required this.monthsCount,
    required this.sumRub,
  });

  /// Способ оплаты.
  final String paymentMethod;

  /// Количество месяцев подписки.
  final int monthsCount;

  /// Сумма заказа.
  final int sumRub;

  /// Сериализует объект в JSON.
  Map<String, dynamic> toJson() => {
        'PAYMENT_TYPE': paymentMethod,
        'COUNT': monthsCount,
        'SUM': sumRub,
      };

  @override
  List<Object?> get props => [
        paymentMethod,
        monthsCount,
        sumRub,
      ];
}
