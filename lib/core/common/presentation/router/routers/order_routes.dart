import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/payment_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/product_routes.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

abstract final class OrderRoutes {
  static AutoRoute get routes => AutoRoute(
        page: OrdersWrapper.page,
        children: [
          AutoRoute(
            page: OrdersRoute.page,
            title: (_, __) => t.recentOrders.myOrders,
          ),
          AutoRoute(
            page: OneOrderRoute.page,
          ),
          ProductRoutes.routes,
          PaymentRoutes.routes,
        ],
      );
}
