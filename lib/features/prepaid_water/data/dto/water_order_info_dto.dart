import 'package:niagara_app/core/core.dart';

/// DTO для передачи информации о заказе на пополнение баланса предоплатной воды
/// на сервер.
class WaterOrderInfoDto extends Equatable {
  const WaterOrderInfoDto({
    required this.paymentMethod,
    required this.complectId,
    required this.count,
  });

  /// Способ оплаты.
  final String paymentMethod;

  /// `ID` комплекта.
  final String complectId;

  /// Количество комплектов.
  final int count;

  /// Сериализует объект в JSON.
  Map<String, dynamic> toJson() => {
        'PAYMENT_TYPE': paymentMethod,
        'COMPLECT': complectId,
        'COUNT': count,
      };

  @override
  List<Object?> get props => [
        paymentMethod,
        complectId,
        count,
      ];
}
