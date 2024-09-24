part of 'promotions_cubit.dart';

@freezed
class PromotionsState with _$PromotionsState {
  const factory PromotionsState.loading() = _Loading;

  const factory PromotionsState.loaded({
    required List<Promotion> promotions,
  }) = _Loaded;

  const factory PromotionsState.error() = _Error;
}
