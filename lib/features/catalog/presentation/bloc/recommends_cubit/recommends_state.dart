part of 'recommends_cubit.dart';

@freezed
class RecommendsState with _$RecommendsState {
  const factory RecommendsState.loading() = _Loading;

  const factory RecommendsState.loaded({
    required List<Product> products,
  }) = _Loaded;

  const factory RecommendsState.error() = _Error;
}
