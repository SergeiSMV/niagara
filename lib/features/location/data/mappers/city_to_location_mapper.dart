import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/data/models/city_model.dart';
import 'package:niagara_app/features/location/domain/entities/location.dart';

extension CityToLocationExt on CityModel {
  Location toLocation() {
    final coordinates = (lat, lon);
    final name = city;
    return Location(
      coordinates: coordinates,
      name: name,
      description: '',
      precision: LocationPrecision.other,
      address: LocationAddress(
        province: region,
        locality: city,
      ),
    );
  }
}
