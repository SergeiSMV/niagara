import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc.dart';

@RoutePage()
/// Обертка для страницы авторизации. Используется для
/// обертки страницы в [BlocProvider] для работы с [AuthBloc].
class AuthWrapperPage extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: const AutoRouter(),
    );
  }
}
