import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependencies/di.dart';
import '../../../prepaid_water/presentation/bloc/balance_cubit/water_balance_cubit.dart';
import '../../../vip/presentation/bloc/vip_activation_selection_cubit/vip_activation_selection_cubit.dart';
import '../../../vip/presentation/bloc/vip_description_bloc/vip_description_bloc.dart';
import '../../user/presentation/bloc/user_bloc.dart';
import 'bloc/bonuses_bloc/bonuses_bloc.dart';

/// [AutoRouteWrapper] для различных модулей программы лояльности: бонусная
/// программа, предоплатная вода, VIP-подписка.
///
/// Нужен для отделения этих модулей от профиля пользователя.
@RoutePage()
class LoyaltyProgramWrapper implements AutoRouteWrapper {
  const LoyaltyProgramWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<UserBloc>()),
          BlocProvider.value(value: getIt<BonusesBloc>()),
          BlocProvider(create: (_) => getIt<VipDescriptionBloc>()),
          BlocProvider(create: (_) => getIt<VipActivationSelectionCubit>()),
          BlocProvider.value(value: getIt<WaterBalanceCubit>()),
        ],
        child: const AutoRouter(),
      );
}
