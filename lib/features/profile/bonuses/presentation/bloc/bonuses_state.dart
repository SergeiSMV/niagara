part of 'bonuses_bloc.dart';

@freezed
class BonusesState with _$BonusesState {
  const factory BonusesState.initial() = _Initial;
  const factory BonusesState.loading() = _Loading;
  const factory BonusesState.loaded({
    required Bonuses bonuses,
  }) = _Loaded;
  const factory BonusesState.error({
    required String message,
  }) = _Error;
}
