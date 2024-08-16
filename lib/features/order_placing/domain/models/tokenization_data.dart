import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';

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

  final String orderId;
  final String shopId;
  final String applicationKey;
  final String title;
  final String description;
  final String customerId;
  final String price;
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
