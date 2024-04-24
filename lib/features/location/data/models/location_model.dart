// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/utils/enums/location_precision.dart';

part 'location_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class LocationModel extends Equatable {
  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.province,
    required this.city,
    required this.locality,
    required this.district,
    required this.street,
    required this.house,
    required this.floor,
    required this.flat,
    required this.entrance,
    required this.name,
    required this.description,
    this.precision = LocationPrecision.other,
    this.isPrimary = false,
    this.deliveryId,
    this.serviceLastDate,
    this.serviceNextDate,
    this.isActive,
  });

  @JsonKey(name: 'LAT')
  final double latitude;

  @JsonKey(name: 'LAN')
  final double longitude;

  @JsonKey(name: 'REGION')
  final String province;

  final String city;

  @JsonKey(name: 'LOCATION')
  final String locality;

  final String district;
  final String street;

  @JsonKey(name: 'BUILD')
  final String house;

  final String floor;

  @JsonKey(name: 'FLAT_OFFICE_NUMBER')
  final String flat;

  final String entrance;

  final String name;

  @JsonKey(name: 'ADDITIONAL_INFO')
  final String description;

  @JsonKey(name: 'ID')
  final String? deliveryId;

  @JsonKey(name: 'SERVICE_LAST_DATE')
  final DateTime? serviceLastDate;

  @JsonKey(name: 'SERVICE_NEXT_DATE')
  final DateTime? serviceNextDate;

  @JsonKey(name: 'ACTIVE')
  final bool? isActive;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final LocationPrecision precision;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isPrimary;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        province,
        city,
        locality,
        district,
        street,
        house,
        floor,
        flat,
        entrance,
        name,
        description,
        precision,
        isPrimary,
      ];
}
