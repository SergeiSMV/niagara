import 'package:niagara_app/core/common/data/database/_imports.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AddressesTable,
    CitiesTable,
    ShopsTable,
    UsersTable,
    BonusesTable,
    FavoritesTable,
  ],
  daos: [
    AllAddresses,
    AllCities,
    AllShops,
    AllUsers,
    AllBonuses,
    AllFavorites,
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
