import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/cart/favorites/data/local/tables/favorites_table.dart';

part 'favorites_dao.g.dart';

@DriftAccessor(tables: [FavoritesTable])
class AllFavorites extends DatabaseAccessor<AppDatabase>
    with _$AllFavoritesMixin {
  AllFavorites(super.attachedDatabase);

  Future<List<FavoritesTableData>> getFavorites() async =>
      select(favoritesTable).get();

  Future<void> insertFavorites(
    List<FavoritesTableCompanion> companions,
  ) async =>
      batch((batch) => batch.insertAll(favoritesTable, companions));

  Future<void> deleteAllFavorites() async => delete(favoritesTable).go();

  Future<int> insertFavorite(FavoritesTableCompanion companion) =>
      into(favoritesTable).insert(companion);

  Future<int> deleteFavorite(FavoritesTableCompanion companion) =>
      delete(favoritesTable).delete(companion);
}
