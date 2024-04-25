// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_dto.g.dart';

/// DTO модель местоположения для доставки
@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class LocationDto extends Equatable {
  const LocationDto({
    required this.name,
    required this.region,
    required this.district,
    required this.city,
    required this.location,
    required this.street,
    required this.build,
    required this.floor,
    required this.flat,
    required this.entrance,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.serviceLastDate,
    required this.serviceNextDate,
    required this.onlyRead,
    required this.isDefault,
    required this.isActive,
  });

  final String name;

  final String region;

  final String district;

  final String city;

  final String location;

  final String street;

  final String build;

  final String floor;

  @JsonKey(name: 'FLAT_OFFICE_NUMBER')
  final String flat;

  final String entrance;

  @JsonKey(name: 'ADDITIONAL_INFO')
  final String description;

  @JsonKey(name: 'LAT', fromJson: _getCoordinate)
  final double latitude;

  @JsonKey(name: 'LAN', fromJson: _getCoordinate)
  final double longitude;

  final DateTime serviceLastDate;

  final DateTime serviceNextDate;

  final bool onlyRead;

  @JsonKey(name: 'DEFAULT')
  final bool isDefault;

  @JsonKey(name: 'ACTIVE')
  final bool isActive;

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);

  static double _getCoordinate(String value) =>
      double.parse(value.replaceAll(',', '.'));

  @override
  List<Object?> get props => [
        name,
        region,
        district,
        city,
        location,
        street,
        build,
        floor,
        flat,
        entrance,
        description,
        latitude,
        longitude,
        serviceLastDate,
        serviceNextDate,
        onlyRead,
        isDefault,
        isActive,
      ];
}
