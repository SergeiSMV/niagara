part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.loading() = _Loading;
  const factory FavoritesState.loaded({
    required List<Product> favorites,
  }) = _Loaded;
  const factory FavoritesState.error() = _Error;
}
