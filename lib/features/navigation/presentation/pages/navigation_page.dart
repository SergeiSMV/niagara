import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/navigation_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/check_promo_code_cubit/check_promo_code_cubit.dart';
import 'package:niagara_app/features/cart/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/equipments_bloc/equipments_bloc.dart';
import 'package:niagara_app/features/new_products/presentation/bloc/new_products_bloc.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import 'package:niagara_app/features/promotions/presentation/cubit/promotions_cubit.dart';
import 'package:niagara_app/features/special_poducts/presentation/bloc/special_products_bloc.dart';
import 'package:niagara_app/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Страница [NavigationPage] для внутренней навигации в приложении.
///
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

  /// Отображает кнопку с логами.
  void showLogsButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TalkerScreen(
          talker: getIt<Talker>(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: _routes,
      extendBodyBehindAppBar: true,
      bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBarWidget(
        tabsRouter: tabsRouter,
        fullScreenTabs: _fullScreenTabs,
      ),
      floatingActionButton: 
          AppConstants.kShowDebugButton
          ? FloatingActionButton(
              child: const Icon(Icons.bug_report),
              onPressed: () => showLogsButton(context),
            )
          : null,
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
            create: (_) => getIt<CheckPromoCodeCubit>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<OrdersBloc>(),
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
          BlocProvider(
            create: (_) => getIt<EquipmentsBloc>(),
            lazy: false,
          ),
        ],
        child: this,
      );
}
