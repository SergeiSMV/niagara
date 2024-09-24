import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/prepaid_water/presentation/bloc/balance_cubit/water_balance_cubit.dart';
import 'package:niagara_app/features/profile/about/presentation/bloc/policies_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/bloc/description/referral_bloc.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';
import 'package:niagara_app/features/vip/presentation/bloc/vip_activation_selection_cubit/vip_activation_selection_cubit.dart';
import 'package:niagara_app/features/vip/presentation/bloc/vip_description_bloc/vip_description_bloc.dart';

@RoutePage()
class ProfileWrapper implements AutoRouteWrapper {
  const ProfileWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<UserBloc>()),
          BlocProvider.value(value: getIt<BonusesBloc>()),
          BlocProvider(create: (_) => getIt<VipDescriptionBloc>()),
          BlocProvider(create: (_) => getIt<VipActivationSelectionCubit>()),
          BlocProvider(create: (_) => getIt<ReferralBloc>()),
          BlocProvider(create: (_) => getIt<PoliciesBloc>()),
          BlocProvider(create: (_) => getIt<WaterBalanceCubit>()),
        ],
        child: const AutoRouter(),
      );
}
