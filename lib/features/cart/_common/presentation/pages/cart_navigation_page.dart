import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/tabs_navigation_widget.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/favorites/presentation/bloc/favorites_bloc.dart';

@RoutePage()
class CartNavigationPage extends StatelessWidget {
  const CartNavigationPage({super.key});

  static final _tabs = [
    AppTabItem(
      route: const CartRoute(),
      title: t.routes.cart,
      icon: Assets.icons.shoppingCartFill,
    ),
    AppTabItem(
      route: const FavoritesRoute(),
      title: t.favorites.favorites,
      icon: Assets.icons.likeFill,
    ),
  ];

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getIt<FavoritesBloc>(),
        child: TabsNavigationWidget(
          tabs: _tabs,
          showAppBar: false,
        ),
      );
}
