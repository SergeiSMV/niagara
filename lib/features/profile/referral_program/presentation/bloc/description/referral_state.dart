part of 'referral_bloc.dart';

@freezed
class ReferralState with _$ReferralState {
  const factory ReferralState.loading() = _Loading;

  const factory ReferralState.loaded({
    required ReferralDescription statusDescription,
  }) = _Loaded;

  const factory ReferralState.error({
    required String message,
  }) = _Error;
}
