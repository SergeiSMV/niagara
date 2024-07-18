import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/navigation_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import 'package:niagara_app/features/new_products/presentation/bloc/new_products_bloc.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:niagara_app/features/promotions/presentation/cubit/promotions_cubit.dart';
import 'package:niagara_app/features/special_poducts/presentation/bloc/special_products_bloc.dart';
import 'package:niagara_app/features/stories/presentation/bloc/stories_bloc.dart';

/// Страница [NavigationPage] для внутренней навигации в приложении.
/// Содержит в себе все основные маршруты приложения.
@RoutePage()
class NavigationPage extends StatelessWidget implements AutoRouteWrapper {
  const NavigationPage({super.key});

  static List<PageRouteInfo> get _routes => [
        const HomeRoute(),
        const CatalogRoute(),
        const CartRoute(),
        const EmptyNavigatorRoute(),
        const ProfileRoute(),
      ];

  static Map<int, PageRouteInfo> get _fullScreenTabs => {
        3: const LocationsWrapper(
          children: [
            LocationsTabRoute(children: [ShopsRoute()]),
          ],
        ),
      };

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: _routes,
      extendBodyBehindAppBar: true,
      bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBarWidget(
        tabsRouter: tabsRouter,
        fullScreenTabs: _fullScreenTabs,
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<GroupsCubit>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<PromotionsCubit>(param1: false),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<FavoritesBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<NotificationsBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<CartBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<NewProductsBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<SpecialProductsBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<StoriesBloc>(),
            lazy: false,
          ),
        ],
        child: this,
      );
}
