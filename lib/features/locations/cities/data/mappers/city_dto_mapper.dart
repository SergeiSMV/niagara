import 'package:niagara_app/features/locations/cities/data/remote/dto/city_dto.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';

extension CityDtoMapper on CityDto {
  City toModel() => City(
        id: id,
        coordinates: (latitude, longitude),
        province: region,
        locality: city,
        phone: phone,
        searchSpan: diffLat != null && diffLong != null
            ? (diffLat: diffLat!, diffLong: diffLong!)
            : null,
      );
}

extension CityMapper on City {
  CityDto toDto() => CityDto(
        id: id,
        latitude: coordinates.$1,
        longitude: coordinates.$2,
        region: province,
        city: locality,
        phone: phone,
        diffLat: searchSpan?.diffLat,
        diffLong: searchSpan?.diffLong,
      );
}
