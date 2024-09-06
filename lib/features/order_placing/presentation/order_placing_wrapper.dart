import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/date_selection_cubit/date_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/bloc/payment_method_selection_cubit/payment_method_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/bloc/time_slot_selection_cubit/time_slot_selection_cubit.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/presentation/bloc/create_order/create_order_cubit.dart';
import 'package:niagara_app/features/order_placing/presentation/bloc/delivery_time_options/delivery_time_options_cubit.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

@RoutePage()
class OrderPlacingWrapper implements AutoRouteWrapper {
  const OrderPlacingWrapper({required this.allowedPaymentMethods});

  final List<PaymentMethod> allowedPaymentMethods;

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<UserBloc>()),
          BlocProvider(create: (_) => getIt<OrderCreationCubit>()),
          BlocProvider(create: (_) => getIt<TimeSlotSelectionCubit>()),
          BlocProvider(create: (_) => getIt<DateSelectionCubit>()),
          BlocProvider(
            create: (_) => getIt<PaymentMethodSelectionCubit>(
              param1: allowedPaymentMethods,
            ),
          ),
          BlocProvider(
            create: (_) => getIt<DeliveryTimeOptionsCubit>()..getOptions(),
          ),
        ],
        child: const AutoRouter(),
      );
}
