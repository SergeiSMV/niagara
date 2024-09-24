// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

/// DTO модель местоположения для доставки
@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class AddressDto extends Equatable {
  const AddressDto({
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
    required this.isDefault,
    required this.locationId,
    this.serviceLastDate,
    this.serviceNextDate,
    this.onlyRead,
    this.isActive,
  });

  @JsonKey(name: 'ID')
  final String locationId;

  @JsonKey(name: 'NAME', includeToJson: false)
  final String name;

  @JsonKey(name: 'REGION')
  final String region;

  @JsonKey(name: 'DISTRICT')
  final String district;

  @JsonKey(name: 'CITY')
  final String city;

  @JsonKey(name: 'LOCATION')
  final String location;

  @JsonKey(name: 'STREET')
  final String street;

  @JsonKey(name: 'BUILD')
  final String build;

  @JsonKey(name: 'FLOOR')
  final String floor;

  @JsonKey(name: 'FLAT_OFFICE_NUMBER')
  final String flat;

  @JsonKey(name: 'ENTRANCE')
  final String entrance;

  @JsonKey(name: 'ADDITIONAL_INFO')
  final String description;

  @JsonKey(name: 'LAT', fromJson: _getCoordinate)
  final double latitude;

  @JsonKey(name: 'LAN', fromJson: _getCoordinate)
  final double longitude;

  @JsonKey(name: 'SERVICE_LAST_DATE', includeToJson: false)
  final DateTime? serviceLastDate;

  @JsonKey(name: 'SERVICE_NEXT_DATE', includeToJson: false)
  final DateTime? serviceNextDate;

  @JsonKey(name: 'ONLY_READ', includeToJson: false)
  final bool? onlyRead;

  @JsonKey(name: 'DEFAULT', includeToJson: false)
  final bool isDefault;

  @JsonKey(name: 'ACTIVE', includeToJson: false)
  final bool? isActive;

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

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
        locationId,
      ];
}
