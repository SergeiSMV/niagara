import 'package:niagara_app/core/core.dart';

/// Информация о заказе на пополнение счета воды.
class OrderWaterData extends Equatable {
  const OrderWaterData({required this.productId, required this.count});

  /// `ID` товара.
  final String productId;

  /// Количество тар воды.
  final int count;

  @override
  List<Object?> get props => [productId, count];
}
