import 'package:niagara_app/core/core.dart';

/// Чек заказа.
///
/// Содержит `ID` ассоциированного заказа и строку с `HTML`-документом.
class OrderReceipt extends Equatable {
  const OrderReceipt({required this.orderId, required this.html});

  /// Идентификатор заказа.
  final String orderId;

  /// `HTML`-документ с чеком заказа.
  final String html;

  @override
  List<Object?> get props => [orderId, html];
}
