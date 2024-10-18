import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля оплат.
///
/// Включает себя роуты для переиспользуемого модуля оплат (без оплат из
/// корзины).
abstract final class PaymentRoutes {
  static AutoRoute get routes => AutoRoute(
        page: PaymentWrapper.page,
        children: [
          AutoRoute(page: PaymentCreationRoute.page),
          AutoRoute(
            page: PaymentInstructionsRoute.page,
            title: (_, __) => t.orderPlacing.paymentProcess,
          ),
          AutoRoute(page: OrderResultRoute.page),
        ],
      );
}
