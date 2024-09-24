part of 'policies_bloc.dart';

@freezed
class PoliciesState with _$PoliciesState {
  const factory PoliciesState.loading() = _Loading;

  const factory PoliciesState.loaded({
    required Policy policy,
  }) = _Loaded;

  const factory PoliciesState.error({
    required String message,
  }) = _Error;
}
