import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/payment_method_selection_cubit/payment_method_selection_cubit.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/payments/presentation/bloc/payment_creation_cubit/payment_creation_cubit.dart';
import 'package:niagara_app/features/prepaid_water/domain/model/prepaid_water_order_data.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';

@RoutePage()
class PaymentWrapper implements AutoRouteWrapper {
  const PaymentWrapper({this.activationOption, this.prepaidWaterData});

  final ActivationOption? activationOption;

  final PrepaidWaterOrderData? prepaidWaterData;

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<PaymentMethodSelectionCubit>(
              param1: PaymentMethod.onlineMethods,
            ),
          ),
          BlocProvider(
            create: (_) => getIt<PaymentCreationCubit>(
              param1: activationOption,
              param2: prepaidWaterData,
            ),
          ),
        ],
        child: const AutoRouter(),
      );
}
