import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/filters_cubit/filters_cubit.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';

@RoutePage()
class CategoryWrapperPage implements AutoRouteWrapper {
  const CategoryWrapperPage({
    required this.group,
  });

  final Group group;
  String get key => group.props.toString();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            key: Key(key),
            create: (_) => getIt<ProductsBloc>(param1: group),
          ),
          BlocProvider(
            key: Key(key),
            create: (_) => getIt<FiltersCubit>(param1: group),
          ),
          BlocProvider.value(value: getIt<CartBloc>()),
          BlocProvider.value(value: getIt<GroupsCubit>()),
          BlocProvider.value(value: getIt<FavoritesBloc>()),
        ],
        child: const AutoRouter(),
      );
}
