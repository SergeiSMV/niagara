import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/models/city_model.dart';

extension CityCompanionMapper on CityModel {
  CitiesCompanion toCompanion() {
    return CitiesCompanion(
      latitude: Value(lat),
      longitude: Value(lon),
      region: Value(region),
      city: Value(city),
    );
  }
}
