import 'package:niagara_app/core/core.dart';

/// `DTO` для получения чека заказа.
class OrderReceiptDto extends Equatable {
  const OrderReceiptDto({required this.html, required this.orderId});

  /// `HTML`-документ с чеком заказа.
  final String html;

  /// Идентификатор заказа.
  final String orderId;

  @override
  List<Object?> get props => [html, orderId];
}
