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
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        beforeOpen: (_) async => customStatement('PRAGMA foreign_keys = ON'),
        onUpgrade: (m, from, to) async {
          try {
            if (from < 10) {
              // Безопасно добавляем новые поля без удаления таблиц
              try {
                // Добавляем поле orders_count в users_table если его нет
                await m.addColumn(usersTable, usersTable.ordersCount);
                // Устанавливаем значение по умолчанию для существующих записей
                await customStatement(
                    'UPDATE users_table SET orders_count = 0 WHERE orders_count IS NULL');
              } on SqliteException catch (e) {
                // Поле уже существует, пропускаем
                getIt<IAppLogger>().log(
                  level: LogLevel.info,
                  message:
                      'Field orders_count already exists in users_table $e',
                );
              }

              try {
                // Добавляем поле pickup в user_orders_table если его нет
                await m.addColumn(userOrdersTable, userOrdersTable.pickup);
                // Устанавливаем значение по умолчанию для существующих записей
                await customStatement(
                    'UPDATE user_orders_table SET pickup = 0 WHERE pickup IS NULL');
              } on SqliteException catch (e) {
                // Поле уже существует, пропускаем
                getIt<IAppLogger>().log(
                  level: LogLevel.info,
                  message:
                      'Field pickup already exists in user_orders_table $e',
                );
              }
            }
          } on SqliteException catch (e, st) {
            getIt<IAppLogger>().log(
              level: LogLevel.error,
              message: 'Error during database migration: $e',
              error: e,
              stackTrace: st,
            );

            // Вместо удаления всех таблиц, пытаемся создать недостающие
            getIt<IAppLogger>().log(
              level: LogLevel.warning,
              message: 'Attempting to create missing tables...',
            );

            try {
              // Создаем только те таблицы, которых нет
              for (final table in allTables) {
                try {
                  await m.createTable(table);
                } on SqliteException catch (e) {
                  // Таблица уже существует, пропускаем
                  getIt<IAppLogger>().log(
                    level: LogLevel.info,
                    message: 'Table ${table.actualTableName} already exists $e',
                  );
                }
              }
            } on SqliteException catch (fallbackError) {
              getIt<IAppLogger>().log(
                level: LogLevel.error,
                message: 'Fallback migration failed: $fallbackError',
                error: fallbackError,
              );
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
