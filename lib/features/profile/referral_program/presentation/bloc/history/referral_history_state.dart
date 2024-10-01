part of 'referral_history_cubit.dart';

@freezed
class ReferralHistoryState with _$ReferralHistoryState {
  const factory ReferralHistoryState.initial() = _Initial;

  const factory ReferralHistoryState.loading() = _Loading;

  const factory ReferralHistoryState.loaded({
    required List<ReferralHistoryItem> history,
    required bool hasMore,
  }) = _Loaded;

  const factory ReferralHistoryState.error() = _Error;
}
