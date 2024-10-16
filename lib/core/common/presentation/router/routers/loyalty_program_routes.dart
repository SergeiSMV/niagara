import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

abstract final class LoyaltyProgramRoutes {
  static AutoRoute get routes => AutoRoute(
        page: LoyaltyProgramWrapper.page,
        children: [
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
            page: VipRoute.page,
            title: (_, __) => t.vip.pageTitle,
          ),
          AutoRoute(
            page: PrepaidWaterRoute.page,
            title: (_, __) => t.prepaidWater.title,
          ),
        ],
      );
}
