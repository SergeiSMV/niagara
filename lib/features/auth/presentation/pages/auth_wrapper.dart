import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';
import 'package:niagara_app/features/auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';
import 'package:niagara_app/features/auth/presentation/pages/auth_navigation_observer.dart';

/// Обертка для страницы авторизации. Используется для
/// обертки страницы в [BlocProvider] для работы с [AuthBloc].
@RoutePage()
class AuthWrapperPage extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<ValidatePhoneCubit>()),
        BlocProvider(create: (_) => getIt<CountdownTimerCubit>()),
      ],
      child: AutoRouter(
        navigatorObservers: () => [
          getIt<AuthNavigatorObserver>(),
        ],
      ),
    );
  }
}
