import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/auth_navigation_observer.dart';

/// [AuthWrapper] - обертка страницы для работы с необходимыми states,
/// а также добавляет наблюдателя для отслеживания навигации внутри авторизации.
@RoutePage()
class AuthWrapper extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<AuthBloc>()),
          BlocProvider(create: (_) => getIt<ValidatePhoneCubit>()),
        ],
        child: AutoRouter(
          navigatorObservers: () => [
            getIt<AuthNavigatorObserver>(),
          ],
        ),
      );
}
