import 'package:niagara_app/features/locations/cities/data/remote/dto/city_dto.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';

extension CityDtoMapper on CityDto {
  City toModel() => City(
        id: id,
        coordinates: (latitude, longitude),
        province: region,
        locality: city,
        phone: phone,
      );
}
