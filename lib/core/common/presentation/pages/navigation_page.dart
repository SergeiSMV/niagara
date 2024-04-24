import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/navigation_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';

/// Страница [NavigationPage] для внутренней навигации в приложении.
/// Содержит в себе все основные маршруты приложения.
@RoutePage()
class NavigationPage extends StatelessWidget implements AutoRouteWrapper {
  const NavigationPage({super.key});

  static List<PageRouteInfo> get _routes => [
        const HomeRoute(),
        const CatalogRoute(),
        const CartRoute(),
        const ShopsRoute(),
        const ProfileRoute(),
      ];

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<LocationsBloc>()..add(const LocationsEvent.loadLocations()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: _routes,
      bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBarWidget(
        tabsRouter: tabsRouter,
      ),
    );
  }
}
