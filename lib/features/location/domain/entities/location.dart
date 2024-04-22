// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    this.comment,
  });

  final (double latitude, double longitude) coordinates;
  final String name;
  final String description;
  final LocationPrecision precision;
  final LocationAddress address;
  final String? comment;

  @override
  List<Object?> get props => [
        coordinates,
        name,
        description,
        precision,
        address,
        comment,
      ];

  Location copyWith({
    (double latitude, double longitude)? coordinates,
    String? name,
    String? description,
    LocationPrecision? precision,
    LocationAddress? address,
    String? comment,
  }) {
    return Location(
      coordinates: coordinates ?? this.coordinates,
      name: name ?? this.name,
      description: description ?? this.description,
      precision: precision ?? this.precision,
      address: address ?? this.address,
      comment: comment ?? this.comment,
    );
  }
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
    this.flat,
    this.entrance,
    this.floor,
  });

  final String? country;
  final String? province;
  final String? area;
  final String? locality;
  final String? district;
  final String? street;
  final String? house;
  final String? flat;
  final String? entrance;
  final String? floor;

  @override
  List<Object?> get props => [
        country,
        province,
        area,
        locality,
        district,
        street,
        house,
        flat,
        entrance,
        floor,
      ];

  LocationAddress copyWith({
    String? country,
    String? province,
    String? area,
    String? locality,
    String? district,
    String? street,
    String? house,
    String? flat,
    String? entrance,
    String? floor,
  }) {
    return LocationAddress(
      country: country ?? this.country,
      province: province ?? this.province,
      area: area ?? this.area,
      locality: locality ?? this.locality,
      district: district ?? this.district,
      street: street ?? this.street,
      house: house ?? this.house,
      flat: flat ?? this.flat,
      entrance: entrance ?? this.entrance,
      floor: floor ?? this.floor,
    );
  }
}
