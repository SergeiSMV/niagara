import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/check_promocode_state.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/check_promo_code_use_case.dart';

@injectable
class CheckPromoCodeCubit extends Cubit<CheckPromoCodeState> {
  CheckPromoCodeCubit(
    this._checkPromoCodeUseCase,
  ) : super(CheckPromoCodeState.initial);

  final CheckPromoCodeUseCase _checkPromoCodeUseCase;

  String? promocode;

  void reset() => emit(CheckPromoCodeState.initial);

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
