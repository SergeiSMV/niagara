import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/orders_bloc/orders_bloc.dart';

@RoutePage()
class OrdersWrapper implements AutoRouteWrapper {
  const OrdersWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [BlocProvider.value(value: getIt<OrdersBloc>())],
        child: const AutoRouter(),
      );
}
