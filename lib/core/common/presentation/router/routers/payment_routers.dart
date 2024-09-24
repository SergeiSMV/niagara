import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';

/// Класс роутера для модуля оплат
abstract final class PaymentRouters {
  static AutoRoute get routers => AutoRoute(
        page: PaymentWrapper.page,
        children: [
          AutoRoute(page: PaymentCreationRoute.page),
          AutoRoute(page: PaymentInstructionsRoute.page),
          AutoRoute(page: OrderResultRoute.page),
        ],
      );
}
