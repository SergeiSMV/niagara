import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля Profile (Профиль)
abstract final class ProfileRouters {
  static AutoRoute get routers => AutoRoute(
        page: ProfileWrapper.page,
        children: [
          AutoRoute(
            page: ProfileRoute.page,
            initial: true,
            title: (_, __) => '',
          ),
          AutoRoute(
            page: MyBonusesRoute.page,
            title: (_, __) => t.bonuses.myCard,
          ),
          AutoRoute(
            page: BonusesFaqRoute.page,
            title: (_, __) => t.bonuses.bonusesFaqs,
          ),
          AutoRoute(
            page: AboutBonusesRoute.page,
            title: (_, __) => t.bonuses.aboutBonuses,
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
          AutoRoute(
            page: VipRoute.page,
            title: (_, __) => t.vip.pageTitle,
          ),
          AutoRoute(
            title: (_, __) => t.referral.referralProgram,
            page: ReferralRoute.page,
          ),
          AutoRoute(
            title: (_, __) => t.profile.aboutApp.pageTitle,
            page: AboutAppRoute.page,
          ),
          AutoRoute(
            page: PolicyRoute.page,
          ),
        ],
      );
}
