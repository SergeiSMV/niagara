import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';

/// Наблюдатель для навигации внутри авторизации.
/// Останавливает таймер обратного отсчета при закрытии экрана ввода кода.
@injectable
class AuthNavigatorObserver extends NavigatorObserver {
  AuthNavigatorObserver(this._countdownTimerCubit);

  final CountdownTimerCubit _countdownTimerCubit;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _countdownTimerCubit.stopTimer();
  }
}
