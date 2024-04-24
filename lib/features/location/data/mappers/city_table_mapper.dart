import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/models/city_model.dart';

extension CityTableMapper on CitiesTable {
  CityModel toModel() => CityModel(
        lat: latitude,
        lon: longitude,
        region: region,
        city: city,
      );
}
