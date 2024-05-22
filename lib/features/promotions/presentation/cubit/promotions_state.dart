part of 'promotions_cubit.dart';

@freezed
class PromotionsState with _$PromotionsState {
  const factory PromotionsState.initial() = _Initial;

  const factory PromotionsState.loading() = _Loading;

  const factory PromotionsState.loaded(List<Promotion> promotions) = _Loaded;

  const factory PromotionsState.error() = _Error;
}
