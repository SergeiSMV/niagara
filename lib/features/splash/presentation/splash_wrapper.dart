import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:niagara_app/features/splash/presentation/cubit/splash_cubit.dart';

@RoutePage()
class SplashWrapper extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SplashCubit>()),
        BlocProvider(create: (_) => getIt<OnboardingCubit>()),
      ],
      child: const AutoRouter(),
    );
  }
}
