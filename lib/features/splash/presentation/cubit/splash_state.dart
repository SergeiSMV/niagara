part of 'splash_cubit.dart';

@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState.initial() = _SplashInitial;
  const factory SplashState.readyToAuth() = _SplashReadyToAuth;
  const factory SplashState.readyToMain() = _SplashReadyToMain;
  const factory SplashState.readyToOnboarding() = _SplashReadyToOnboarding;
  const factory SplashState.error() = _SplashError;
}
