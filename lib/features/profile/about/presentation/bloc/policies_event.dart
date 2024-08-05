part of 'policies_bloc.dart';

@freezed
class PoliciesEvent with _$PoliciesEvent {
  const factory PoliciesEvent.getPolicy({required PolicyType type}) =
      _StartedEvent;
}
