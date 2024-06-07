import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/favorites/domain/use_cases/add_favorite_use_case.dart';
import 'package:niagara_app/features/cart/favorites/domain/use_cases/get_favorites_use_case.dart';
import 'package:niagara_app/features/cart/favorites/domain/use_cases/remove_all_favorites_use_case.dart';
import 'package:niagara_app/features/cart/favorites/domain/use_cases/remove_favorite_use_case.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

typedef _Emit = Emitter<FavoritesState>;

@lazySingleton
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(
    this._getFavoritesUseCase,
    this._addFavoriteUseCase,
    this._removeFavoriteUseCase,
    this._removeAllFavoritesUseCase,
  ) : super(const _Loading()) {
    on<_GetFavorites>(_onGetFavorites);
    on<_AddFavorite>(_onAddFavorite);
    on<_RemoveFavorite>(_onRemoveFavorite);
    on<_RemoveAllFavorites>(_onRemoveAllFavorites);

    add(const _GetFavorites());
  }

  final GetFavoritesUseCase _getFavoritesUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;
  final RemoveAllFavoritesUseCase _removeAllFavoritesUseCase;

  Future<void> _onGetFavorites(
    _GetFavorites event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _getFavorites(emit);
  }

  Future<void> _onAddFavorite(
    _AddFavorite event,
    _Emit emit,
  ) =>
      _addFavoriteUseCase.call(event.product).fold(
            (_) => emit(const FavoritesState.error()),
            (_) async => await _getFavorites(emit),
          );

  Future<void> _onRemoveFavorite(
    _RemoveFavorite event,
    _Emit emit,
  ) =>
      _removeFavoriteUseCase.call(event.product).fold(
            (_) => emit(const FavoritesState.error()),
            (_) async => await _getFavorites(emit),
          );

  Future<void> _onRemoveAllFavorites(
    _RemoveAllFavorites event,
    _Emit emit,
  ) =>
      _removeAllFavoritesUseCase.call().fold(
            (_) => emit(const FavoritesState.error()),
            (_) async => await _getFavorites(emit),
          );

  Future<void> _getFavorites(_Emit emit) async =>
      await _getFavoritesUseCase.call().fold(
            (_) => emit(const FavoritesState.error()),
            (favorites) => emit(
              FavoritesState.loaded(
                favorites: favorites,
              ),
            ),
          );
}
