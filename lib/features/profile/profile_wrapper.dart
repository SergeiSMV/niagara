import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/bloc/description/referral_bloc.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/bloc/history/referral_history_cubit.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/bloc/referral_code/referral_code_cubit.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/package/package_info_cubit.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

@RoutePage()
class ProfileWrapper implements AutoRouteWrapper {
  const ProfileWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<UserBloc>()),
          BlocProvider(create: (_) => getIt<ReferralBloc>()),
          BlocProvider(create: (_) => getIt<ReferralCodeCubit>()),
          BlocProvider(create: (_) => getIt<ReferralHistoryCubit>()),
          BlocProvider(create: (_) => getIt<PackageDataCubit>()),
          BlocProvider(create: (_) => getIt<BonusesBloc>()),
        ],
        child: const AutoRouter(),
      );
}
