part of 'bonuses_bloc.dart';

@freezed
class BonusesEvent with _$BonusesEvent {
  const factory BonusesEvent.started() = _StartedEvent;
}
