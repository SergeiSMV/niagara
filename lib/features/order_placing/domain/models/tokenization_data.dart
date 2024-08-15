import 'package:niagara_app/core/core.dart';

class TokenizationData extends Equatable {
  const TokenizationData({
    required this.orderId,
    required this.shopId,
    required this.applicationKey,
    required this.title,
    required this.description,
    required this.customerId,
  });

  final String orderId;
  final String shopId;
  final String applicationKey;
  final String title;
  final String description;
  final String customerId;

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
