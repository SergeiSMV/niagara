// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';

/// DTO для города с удаленного сервера.

class CityDto extends Equatable {
  const CityDto({
    required this.region,
    required this.id,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.diffLat,
    required this.diffLong,
  });

  final String region;
  final int id;
  final String city;
  final double latitude;
  final double longitude;
  final double? diffLat;
  final double? diffLong;
  final String phone;

  factory CityDto.fromJson(Map<String, dynamic> json) => CityDto(
        region: json['REGION'] as String,
        id: (json['CITY_ID'] as num).toInt(),
        city: json['CITY'] as String,
        latitude: _getCoordinate(json['LAT'] as String),
        longitude: _getCoordinate(json['LAN'] as String),
        diffLat: _getCoordinateOrNull(json['DX'] as String?),
        diffLong: _getCoordinateOrNull(json['DY'] as String?),
        phone: json['PHONE'] as String,
      );

  static double _getCoordinate(String value) =>
      double.parse(value.replaceAll(',', '.'));

  static double? _getCoordinateOrNull(String? value) =>
      value != null && value.isNotEmpty ? _getCoordinate(value) : null;

  @override
  List<Object?> get props => [
        region,
        id,
        city,
        latitude,
        longitude,
        phone,
      ];
}
