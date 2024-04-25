import 'package:equatable/equatable.dart';
import 'package:niagara_app/core/utils/enums/location_precision.dart';

/// Модель местоположения для доставки в базе данных
class LocationEntity extends Equatable {
  const LocationEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.province,
    required this.locality,
    required this.district,
    required this.street,
    required this.house,
    required this.flat,
    required this.entrance,
    required this.floor,
    required this.name,
    required this.description,
    required this.precision,
    required this.isDefault,
  });

  final int id;
  final double latitude;
  final double longitude;
  final String province;
  final String locality;
  final String district;
  final String street;
  final String house;
  final String flat;
  final String entrance;
  final String floor;
  final String name;
  final String description;
  final LocationPrecision precision;
  final bool isDefault;

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
        province,
        locality,
        district,
        street,
        house,
        flat,
        entrance,
        floor,
        name,
        description,
        precision,
        isDefault,
      ];
}
