part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.getFavorites() = _GetFavorites;
  const factory FavoritesEvent.addFavorite(Product product) = _AddFavorite;
  const factory FavoritesEvent.removeFavorite(Product product) =
      _RemoveFavorite;
  const factory FavoritesEvent.removeAllFavorites() = _RemoveAllFavorites;
}
