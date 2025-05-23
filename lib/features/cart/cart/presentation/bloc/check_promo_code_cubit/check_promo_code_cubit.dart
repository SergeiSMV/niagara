import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/utils/enums/check_promocode_state.dart';
import '../../../domain/use_cases/check_promo_code_use_case.dart';

/// [Cubit] для проверки промокода.
@injectable
class CheckPromoCodeCubit extends Cubit<CheckPromoCodeState> {
  CheckPromoCodeCubit(
    this._checkPromoCodeUseCase,
  ) : super(CheckPromoCodeState.initial);

  /// Usecase для проверки промокода.
  final CheckPromoCodeUseCase _checkPromoCodeUseCase;

  /// Промокод.
  String? promocode;

  /// Сброс состояния.
  void reset() {
    promocode = null;
    emit(CheckPromoCodeState.initial);
  }

  /// Проверка промокода.
  Future<void> checkPromoCode() async {
    if ((promocode ?? '').isEmpty) return;

    emit(CheckPromoCodeState.loading);

    promocode = promocode!.trim();

    await _checkPromoCodeUseCase(promocode!).fold(
      (failure) => emit(CheckPromoCodeState.error),
      (result) {
        result
            ? emit(CheckPromoCodeState.valid)
            : emit(CheckPromoCodeState.invalid);
      },
    );
  }
}
