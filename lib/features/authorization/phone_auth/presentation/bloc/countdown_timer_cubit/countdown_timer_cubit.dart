import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';

/// Кубит для работы с таймером обратного отсчета.
/// Возвращает текущее значение таймера.
@injectable
class CountdownTimerCubit extends Cubit<int> {
  CountdownTimerCubit() : super(0);

  StreamSubscription<int>? _timerSubscription;

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }

  void startTimer() {
    emit(AppConstants.kOTPResendTime);
    _timerSubscription?.cancel();
    _timerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (x) => AppConstants.kOTPResendTime - x - 1,
    ).take(AppConstants.kOTPResendTime).listen(emit);
  }

  void stopTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    emit(0);
  }
}
