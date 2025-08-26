import 'package:talker_flutter/talker_flutter.dart';

import '../../../../features/profile/about/data/local/dao/policies_dao.dart';
import '../../../../features/profile/about/data/local/table/policies_table.dart';
import '../../../core.dart';
import '../../../dependencies/di.dart';
import '../../../utils/constants/app_constants.dart';
import '_imports.dart';

part 'app_database.g.dart';

/// База данных для работы с SQLite.
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
  /// Фабричный метод для создания экземпляра [AppDatabase].
  ///
  /// Реализуем паттерн синглтон для работы только с одним экземпляром
  /// даже после перезапуска GetIt.
  factory AppDatabase() => _instance;

  /// Конструктор для создания экземпляра [AppDatabase].
  AppDatabase._() : super(_openConnection());

  /// Экземпляр [AppDatabase].
  static final AppDatabase _instance = AppDatabase._();

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        beforeOpen: (_) async => customStatement('PRAGMA foreign_keys = ON'),
        onUpgrade: (m, from, to) async {
          if (from < 11) {
            await m.deleteTable(usersTable.actualTableName);
            await m.createTable(usersTable);

            getIt<IAppLogger>().log(
              level: LogLevel.info,
              message: 'Cleared and re-created all tables',
            );
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
