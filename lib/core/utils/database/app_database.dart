import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/enums/bonus_level_type.dart';
import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/data/cities/local/dao/cities_dao.dart';
import 'package:niagara_app/features/location/data/cities/local/tables/cities_table.dart';
import 'package:niagara_app/features/location/data/locations/local/dao/location_dao.dart';
import 'package:niagara_app/features/location/data/locations/local/tables/location_table.dart';
import 'package:niagara_app/features/profile/data/local/dao/bonuses_dao.dart';
import 'package:niagara_app/features/profile/data/local/dao/user_dao.dart';
import 'package:niagara_app/features/profile/data/local/entities/bonuses_entity.dart';
import 'package:niagara_app/features/profile/data/local/tables/bonuses_table.dart';
import 'package:niagara_app/features/profile/data/local/tables/users_table.dart';
import 'package:niagara_app/features/location/data/shops/local/dao/shops_dao.dart';
import 'package:niagara_app/features/location/data/shops/local/entities/shop_entity.dart';
import 'package:niagara_app/features/location/data/shops/local/tables/shops_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    LocationsTable,
    CitiesTable,
    UsersTable,
    BonusesTable,
    ShopsTable,
  ],
  daos: [
    AllLocations,
    AllCities,
    AllUsers,
    AllBonuses,
    AllShops,
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
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });
