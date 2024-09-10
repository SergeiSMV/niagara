import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/check_promo_code_use_case.dart';

part 'check_promo_code_state.dart';
part 'check_promo_code_cubit.freezed.dart';

@injectable
class CheckPromoCodeCubit extends Cubit<CheckPromoCodeState> {
  CheckPromoCodeCubit(
    this._checkPromoCodeUseCase,
  ) : super(const CheckPromoCodeState.initial());

  final CheckPromoCodeUseCase _checkPromoCodeUseCase;

  String? promoCode;

  Future<void> checkPromoCode() async {
    if ((promoCode ?? '').isEmpty) return;

    emit(const CheckPromoCodeState.initial());

    await _checkPromoCodeUseCase(promoCode!).fold(
      (failure) => emit(const CheckPromoCodeState.error()),
      (result) {
        result
            ? emit(const CheckPromoCodeState.valid())
            : emit(const CheckPromoCodeState.invalid());
      },
    );
  }
}
