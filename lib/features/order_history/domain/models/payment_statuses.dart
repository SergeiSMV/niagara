import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum PaymentStatuses {
  paidFor,
  notPaidFor;

  String toLocale() => switch (this) {
        PaymentStatuses.paidFor => t.recentOrders.paymentStatuses.paidFor,
        PaymentStatuses.notPaidFor => t.recentOrders.paymentStatuses.notPaidFor,
      };
}
