part of 'referral_bloc.dart';

@freezed
class ReferralEvent with _$ReferralEvent {
  const factory ReferralEvent.started() = _StartedEvent;
}
