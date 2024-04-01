import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';

@injectable
/// Кубит для отсчета времени.
class CountdownTimerCubit extends Cubit<int> {
  /// Создает экземпляр [CountdownTimerCubit].
  CountdownTimerCubit() : super(0);

  StreamSubscription<int>? _timerSubscription;

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }

  /// Запускает таймер.
  void startTimer() {
    emit(AppConst.kOTPResendTime);
    _timerSubscription?.cancel();
    _timerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (x) => AppConst.kOTPResendTime - x - 1,
    ).take(AppConst.kOTPResendTime).listen(emit);
  }

  /// Останавливает таймер.
  void stopTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    emit(0);
  }
}
