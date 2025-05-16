import 'package:talker_flutter/talker_flutter.dart';

import '../../../../features/profile/about/data/local/dao/policies_dao.dart';
import '../../../../features/profile/about/data/local/table/policies_table.dart';
import '../../../core.dart';
import '../../../dependencies/di.dart';
import '../../../utils/constants/app_constants.dart';
import '_imports.dart';

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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        beforeOpen: (_) async => customStatement('PRAGMA foreign_keys = ON'),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            final existingUserColumns = await customSelect(
              'PRAGMA table_info(users_table);',
              readsFrom: {usersTable},
            ).get();

            // Проверка перед добавлением поля orders_count:
            final hasOrdersCount = existingUserColumns.any(
              (row) => row.read<String>('name') == usersTable.ordersCount.name,
            );
            if (!hasOrdersCount) {
              await m.addColumn(usersTable, usersTable.ordersCount);
            }

            // Проверка перед добавлением поля pickup:
            final existingColumns = await customSelect(
              'PRAGMA table_info(user_orders_table);',
              readsFrom: {userOrdersTable},
            ).get();

            final hasPickup = existingColumns.any(
              (row) => row.read<String>('name') == userOrdersTable.pickup.name,
            );
            if (!hasPickup) {
              await m.addColumn(userOrdersTable, userOrdersTable.pickup);
            }
          }
        },
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
