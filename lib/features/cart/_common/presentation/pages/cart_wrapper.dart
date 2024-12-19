import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/cart/favorites/presentation/bloc/favorites_bloc.dart';

@RoutePage()
class CartWrapper implements AutoRouteWrapper {
  const CartWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider.value(
        value: getIt<FavoritesBloc>(),
        child: const AutoRouter(),
      );
}
