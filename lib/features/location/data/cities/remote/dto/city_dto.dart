// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_dto.g.dart';

/// DTO для города с удаленного сервера.
@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class CityDto extends Equatable {
  const CityDto({
    required this.region,
    required this.id,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  final String region;

  @JsonKey(name: 'CITY_ID')
  final int id;

  final String city;

  @JsonKey(name: 'LAT', fromJson: double.parse)
  final double latitude;

  @JsonKey(name: 'LAN', fromJson: double.parse)
  final double longitude;

  factory CityDto.fromJson(Map<String, dynamic> json) =>
      _$CityDtoFromJson(json);

  @override
  List<Object?> get props => [
        region,
        id,
        city,
        latitude,
        longitude,
      ];
}
