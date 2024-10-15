import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/order_placing_routers.dart';
import 'package:niagara_app/core/common/presentation/router/routers/payment_routers.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля Home (Главная)
abstract final class HomeRouters {
  static AutoRoute get routers => AutoRoute(
        page: HomeWrapperRoute.page,
        children: [
          AutoRoute(
            page: HomeRoute.page,
            initial: true,
            title: (_, __) => '',
          ),
          AutoRoute(
            page: PromotionsTabRoute.page,
            children: [
              AutoRoute(
                page: PromotionsRoute.page,
                title: (_, __) => t.promos.promotions,
              ),
            ],
          ),
          AutoRoute(
            page: NotificationsRoute.page,
          ),
          AutoRoute(
            page: OneNotificationRoute.page,
          ),
          AutoRoute(
            page: ProductRoute.page,
          ),
          AutoRoute(
            page: VipRoute.page,
            title: (_, __) => t.vip.pageTitle,
          ),
          PaymentRouters.routers,
          OrderPlacingRouters.routers,
        ],
      );
}
