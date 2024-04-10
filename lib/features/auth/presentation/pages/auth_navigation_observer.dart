import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';

/// Наблюдатель для навигации внутри авторизации.
@injectable
class AuthNavigatorObserver extends NavigatorObserver {
  AuthNavigatorObserver({
    required CountdownTimerCubit countdownTimerCubit,
  }) : _countdownTimerCubit = countdownTimerCubit;

  /// Кубит для работы с таймером обратного отсчета.
  final CountdownTimerCubit _countdownTimerCubit;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _countdownTimerCubit.stopTimer();
  }
}
