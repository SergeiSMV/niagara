part of 'vip_bloc.dart';

@freezed
class VipState with _$VipState {
  const factory VipState.loading() = _Loading;

  const factory VipState.loaded({
    required StatusDescription description,
  }) = _Loaded;

  const factory VipState.error({
    required String message,
  }) = _Error;

  const factory VipState.unauthorized() = _Unauthorized;
}
