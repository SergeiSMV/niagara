import 'package:niagara_app/core/common/data/database/_imports.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/profile/about/data/local/dao/policies_dao.dart';
import 'package:niagara_app/features/profile/about/data/local/table/policies_table.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AddressesTable,
    CitiesTable,
    ShopsTable,
    UsersTable,
    BonusesTable,
    FavoritesTable,
    UserOrdersTable,
    PoliciesTable,
  ],
  daos: [
    AllAddresses,
    AllCities,
    AllShops,
    AllUsers,
    AllBonuses,
    AllFavorites,
    AllOrders,
    AllPolicies,
  ],
)
@Singleton()
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        beforeOpen: (_) async => customStatement('PRAGMA foreign_keys = ON'),
      );

  /// Удаляет все данные из всех таблиц. Нужно для очищения кеша при смене
  /// аккаунта.
  Future<void> clearAllTables() async {
    for (final table in allTables) {
      // Некоторые таблицы очищать не нужно или нет смысла.
      if (AppConstants.kNoClearTables.contains(table.actualTableName)) {
        continue;
      }

      final int count = await delete(table).go();

      getIt<IAppLogger>().log(
        level: LogLevel.info,
        message: 'Deleted $count rows from ${table.actualTableName}',
      );
    }
  }
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));

      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });
