import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/payment_method_selection_cubit/payment_method_selection_cubit.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

@RoutePage()
class OrderPlacingWrapper implements AutoRouteWrapper {
  const OrderPlacingWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<UserBloc>()),
          BlocProvider(create: (_) => getIt<PaymentMethodSelectionCubit>()),
        ],
        child: const AutoRouter(),
      );
}
