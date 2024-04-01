import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/splash/presentation/cubit/splash_cubit.dart';

/// Обертка для страницы Splash и инициализации кубита [SplashCubit]
@RoutePage()
class SplashWrapperPage extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>(),
      child: const AutoRouter(),
    );
  }
}
