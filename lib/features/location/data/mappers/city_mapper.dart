import 'package:niagara_app/features/location/data/models/city_model.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';

extension CityMapperExt on CityModel {
  City toCity() => City(
        coordinates: (lat, lon),
        province: region,
        locality: city,
      );
}

extension CityModelMapperExt on City {
  CityModel toModel() => CityModel(
        lat: coordinates.$1,
        lon: coordinates.$2,
        region: province,
        city: locality,
      );
}
