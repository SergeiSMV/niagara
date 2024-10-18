import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля OrderPlacing (Оформление заказа)
abstract final class OrderPlacingRoutes {
  static AutoRoute get routes => AutoRoute(
        page: OrderPlacingWrapper.page,
        children: [
          AutoRoute(
            initial: true,
            page: OrderPlacingRoute.page,
            title: (_, __) => t.orderPlacing.orderPlacing,
          ),
          AutoRoute(
            page: EditProfileRoute.page,
            title: (_, __) => t.profile.edit.pageTitle,
          ),
          AutoRoute(page: OrderResultRoute.page),
          AutoRoute(
            page: PaymentInstructionsRoute.page,
            title: (_, __) => t.orderPlacing.paymentProcess,
          ),
        ],
      );
}
