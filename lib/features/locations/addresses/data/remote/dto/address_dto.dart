// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

  final DateTime? serviceLastDate;

  final DateTime? serviceNextDate;

  final bool? onlyRead;

  @JsonKey(name: 'DEFAULT')
  final bool isDefault;

  @JsonKey(name: 'ACTIVE')
  final bool? isActive;

  @JsonKey(name: 'ID')
  final String locationId;

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
