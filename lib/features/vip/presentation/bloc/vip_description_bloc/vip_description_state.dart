part of 'vip_description_bloc.dart';

@freezed
class VipState with _$VipState {
  const factory VipState.loading() = _Loading;

  const factory VipState.loaded({
    required StatusDescription description,
    String? vipEndDate,
  }) = _Loaded;

  const factory VipState.error() = _Error;

  const factory VipState.unauthorized() = _Unauthorized;
}
