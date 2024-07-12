import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order_status.dart';

class RecentOrder extends Equatable {
  const RecentOrder({
    required this.orderNumber,
    required this.deliveryAddress,
    required this.deliveryDate,
    required this.price,
    required this.status,
  });

  final double orderNumber;
  final String deliveryAddress;
  final String deliveryDate;
  final double price;
  final RecentOrderStatus status;

  @override
  List<Object?> get props => [
        orderNumber,
        deliveryAddress,
        deliveryDate,
        price,
        status,
      ];
}
