import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/navigation_bar.dart';

/// Страница [NavigationPage] для внутренней навигации в приложении. 
/// Содержит в себе все основные маршруты приложения. 
@RoutePage()
class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  static List<PageRouteInfo> get _routes => [
        const HomeRoute(),
        const CatalogRoute(),
        const CartRoute(),
        const ShopsRoute(),
        const ProfileRoute(),
      ];

  @override
  Widget build(BuildContext context) => AutoTabsScaffold(
        routes: _routes,
        bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBarWidget(
          tabsRouter: tabsRouter,
        ),
      );
}
