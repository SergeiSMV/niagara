part of 'vip_bloc.dart';

@freezed
class VipEvent with _$VipEvent {
  const factory VipEvent.started() = _StartedEvent;
}
