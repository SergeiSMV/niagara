import 'package:equatable/equatable.dart';
import 'package:niagara_app/core/utils/enums/location_precision.dart';

/// Модель местоположения по координатам или текстовому запросу (адресу)
class Location extends Equatable {
  const Location({
    required this.coordinates,
    required this.name,
    required this.description,
    required this.precision,
    required this.address,
  });

  final (double latitude, double longitude) coordinates;
  final String name;
  final String description;
  final LocationPrecision precision;
  final LocationAddress address;

  @override
  List<Object?> get props => [
        coordinates,
        name,
        description,
        precision,
        address,
      ];
}

/// Модель адреса местоположения
class LocationAddress extends Equatable {
  const LocationAddress({
    this.country,
    this.province,
    this.area,
    this.locality,
    this.district,
    this.street,
    this.house,
  });

  final String? country;
  final String? province;
  final String? area;
  final String? locality;
  final String? district;
  final String? street;
  final String? house;

  @override
  List<Object?> get props => [
        country,
        province,
        area,
        locality,
        district,
        street,
        house,
      ];
}
