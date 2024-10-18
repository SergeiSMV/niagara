import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/loyalty_program_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/order_placing_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/payment_routes.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля Profile (Профиль)
abstract final class ProfileRoutes {
  static AutoRoute get routes => AutoRoute(
        page: ProfileWrapper.page,
        children: [
          AutoRoute(
            page: ProfileRoute.page,
            initial: true,
            title: (_, __) => '',
          ),
          AutoRoute(
            page: OrdersRoute.page,
            title: (_, __) => t.recentOrders.myOrders,
          ),
          AutoRoute(
            page: OneOrderRoute.page,
          ),
          AutoRoute(
            page: NotificationsRoute.page,
          ),
          AutoRoute(
            page: OneNotificationRoute.page,
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
          PaymentRoutes.routes,
          OrderPlacingRoutes.routes,
          AutoRoute(
            title: (_, __) => t.referral.referralProgram,
            page: ReferralRoute.page,
          ),
          AutoRoute(
            page: EditProfileRoute.page,
            title: (_, __) => t.profile.edit.pageTitle,
          ),
          AutoRoute(
            title: (_, __) => t.profile.aboutApp.pageTitle,
            page: AboutAppRoute.page,
          ),
          AutoRoute(
            page: EquipmentsRoute.page,
            title: (_, __) => t.equipments.myEquipment,
          ),
          AutoRoute(
            page: CleaningRequestRoute.page,
            title: (_, __) => t.equipments.requestForCleaning,
          ),
          AutoRoute(
            page: CleaningOrderSuccessfulRoute.page,
          ),
          LoyaltyProgramRoutes.routes,
        ],
      );
}
