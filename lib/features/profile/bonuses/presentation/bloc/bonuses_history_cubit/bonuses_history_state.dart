part of 'bonuses_history_cubit.dart';

@freezed
class BonusesHistoryState with _$BonusesHistoryState {
  const factory BonusesHistoryState.loading() = _Loading;
  const factory BonusesHistoryState.loaded({
    required List<BonusHistory> history,
    required bool hasMore,
  }) = _Loaded;
  const factory BonusesHistoryState.error() = _Error;
}
