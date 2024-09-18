import 'package:niagara_app/core/core.dart';

/// DTO для передачи информации о заказе на пополнение баланса предоплатной воды
/// на сервер.
class WaterOrderInfoDto extends Equatable {
  const WaterOrderInfoDto({
    required this.paymentMethod,
    required this.productId,
    required this.count,
  });

  /// Способ оплаты.
  final String paymentMethod;

  /// `ID` товара.
  final String productId;

  /// Количество комплектов.
  final int count;

  /// Сериализует объект в JSON.
  Map<String, dynamic> toJson() => {
        'PAYMENT_TYPE': paymentMethod,
        'COMPLECT': productId,
        'COUNT': count,
      };

  @override
  List<Object?> get props => [
        paymentMethod,
        productId,
        count,
      ];
}
