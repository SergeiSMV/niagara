import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/filters_cubit/filters_cubit.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';

@RoutePage()
class CategoryWrapperPage implements AutoRouteWrapper {
  const CategoryWrapperPage({
    required this.group,
  });

  final Group group;

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            key: Key(group.id),
            create: (_) => getIt<ProductsBloc>(param1: group),
          ),
          BlocProvider(
            key: Key(group.id),
            create: (_) => getIt<FiltersCubit>(param1: group),
          ),
        ],
        child: const AutoRouter(),
      );
}
