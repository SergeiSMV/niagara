import 'package:equatable/equatable.dart';
import 'package:niagara_app/core/utils/enums/location_precision.dart';

sealed class Locality extends Equatable {
  const Locality({
    required this.coordinates,
    required this.province,
    required this.locality,
  });

  final (double latitude, double longitude) coordinates;
  final String province;
  final String locality;

  String get name;

  @override
  List<Object?> get props => [
        coordinates,
        province,
        locality,
      ];
}

/// Модель города (населенного пункта)
class City extends Locality {
  const City({
    required super.coordinates,
    required super.province,
    required super.locality,
  });

  @override
  String get name => super.locality;
}

/// Модель местоположения для доставки
class Location extends Locality {
  const Location({
    required super.coordinates,
    required super.province,
    required super.locality,
    required this.precision,
    required this.district,
    required this.street,
    required String name,
    required String description,
    this.house,
    this.flat,
    this.entrance,
    this.floor,
    this.isPrimary = false,
  })  : _name = name,
        _description = description;

  final LocationPrecision precision;
  final bool isPrimary;

  final String district;
  final String street;
  final String? house;
  final String? flat;
  final String? entrance;
  final String? floor;

  final String _name;
  final String _description;

  @override
  String get name => _name;

  String get description => _description;

  Location copyWithoutDetails({
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) =>
      Location(
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
        isPrimary: isPrimary,
      );

  @override
  List<Object?> get props => [
        coordinates,
        province,
        locality,
        precision,
        isPrimary,
        district,
        street,
        house,
        flat,
        entrance,
        floor,
        _name,
        _description,
      ];
}
