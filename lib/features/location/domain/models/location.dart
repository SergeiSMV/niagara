import 'package:niagara_app/core/utils/enums/location_precision.dart';
import 'package:niagara_app/features/location/domain/models/base_locality.dart';

/// Модель местоположения для доставки
class Location extends BaseLocality {
  const Location({
    required super.id,
    required super.coordinates,
    required super.province,
    required super.locality,
    required this.precision,
    required this.district,
    required this.street,
    required this.house,
    required this.flat,
    required this.entrance,
    required this.floor,
    required String name,
    required String description,
    this.isDefault = false,
  })  : _name = name,
        _description = description;

  final String district;
  final String street;
  final String house;
  final String flat;
  final String entrance;
  final String floor;
  final String _name;
  final String _description;
  final LocationPrecision precision;
  final bool isDefault;

  @override
  String get name =>
      street.isNotEmpty && house.isNotEmpty ? '$street $house' : _name;

  String get description => _description;

  Location copyWithoutDetails({
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) =>
      Location(
        id: id,
        coordinates: coordinates,
        province: province,
        locality: locality,
        precision: precision,
        district: district,
        street: street,
        house: house,
        flat: flat ?? this.flat,
        entrance: entrance ?? this.entrance,
        floor: floor ?? this.floor,
        name: name,
        description: comment ?? description,
        isDefault: isDefault,
      );

  @override
  List<Object?> get props => [
        id,
        coordinates,
        province,
        locality,
        precision,
        district,
        street,
        house,
        flat,
        entrance,
        floor,
        _name,
        _description,
        isDefault,
      ];
}
