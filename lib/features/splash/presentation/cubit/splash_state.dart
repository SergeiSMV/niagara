part of 'splash_cubit.dart';

/// Состояние загрузки приложения
@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState.initial() = _SplashInitial;
  const factory SplashState.waiting() = _SplashWaiting;
  const factory SplashState.done() = _SplashDone;
  const factory SplashState.error() = _SplashError;
}
