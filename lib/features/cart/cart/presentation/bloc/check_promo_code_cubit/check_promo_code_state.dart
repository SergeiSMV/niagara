part of 'check_promo_code_cubit.dart';

@freezed
class CheckPromoCodeState with _$CheckPromoCodeState {
  const factory CheckPromoCodeState.initial() = _Initial;

  const factory CheckPromoCodeState.valid() = _Valid;

  const factory CheckPromoCodeState.invalid() = _Invalid;

  const factory CheckPromoCodeState.error() = _Error;
}
