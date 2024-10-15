part of 'banners_cubit.dart';

@freezed
class BannersState with _$BannersState {
  const factory BannersState.loading() = _Loading;
  const factory BannersState.loaded(List<Banner> banners) = _Loaded;
  const factory BannersState.error(String message) = _Error;
}
