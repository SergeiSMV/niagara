import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/tabs_navigation_widget.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

@RoutePage()
class PromotionsTabPage extends StatelessWidget {
  const PromotionsTabPage({super.key});

  static final _tabs = [
    AppTabItem(
      route: PromotionsRoute(isPersonal: false),
      title: t.promos.promotions,
    ),
    AppTabItem(
      route: PromotionsRoute(isPersonal: true),
      title: t.promos.discountForYou,
    ),
  ];

  @override
  Widget build(BuildContext context) => TabsNavigationWidget(tabs: _tabs);
}
