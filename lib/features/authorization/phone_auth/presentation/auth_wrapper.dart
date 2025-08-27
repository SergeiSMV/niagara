import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/dependencies/di.dart';
import 'auth_navigation_observer.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/privacy_check_cubit/privacy_check_cubit.dart';
import 'bloc/validate_phone_cubit/validate_phone_cubit.dart';

/// [AuthWrapper] - обертка страницы для работы с необходимыми states,
/// а также добавляет наблюдателя для отслеживания навигации внутри авторизации.
@RoutePage()
class AuthWrapper extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          /// Блок для работы с аутентификацией
          BlocProvider.value(value: getIt<AuthBloc>()),

          /// Кубит для работы с валидацией номера телефона
          BlocProvider(create: (_) => getIt<ValidatePhoneCubit>()),

          /// Кубит для работы с проверкой согласия на обработку персональных
          /// данных и маркетинговых коммуникаций
          BlocProvider(create: (_) => getIt<PrivacyCheckCubit>()),
        ],
        child: AutoRouter(
          navigatorObservers: () => [
            getIt<AuthNavigatorObserver>(),
          ],
        ),
      );
}
