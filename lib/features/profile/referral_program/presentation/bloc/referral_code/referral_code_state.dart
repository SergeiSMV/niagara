part of 'referral_code_cubit.dart';

@freezed
class ReferralCodeState with _$ReferralCodeState {
  const ReferralCodeState._();

  const factory ReferralCodeState.initial() = _Initial;

  const factory ReferralCodeState.loading() = _Loading;

  const factory ReferralCodeState.loaded(ReferralCodeData data) = _Loaded;

  const factory ReferralCodeState.error() = _Error;

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);
}
