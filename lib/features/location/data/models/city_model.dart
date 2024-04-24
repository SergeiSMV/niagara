// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class CityModel extends Equatable {
  const CityModel({
    required this.lat,
    required this.lon,
    required this.region,
    required this.city,
  });
  
  @JsonKey(fromJson: double.parse)
  final double lat;
  @JsonKey(fromJson: double.parse, name: 'LAN')
  final double lon;
  final String region;
  final String city;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  @override
  List<Object?> get props => [
        region,
        city,
        lat,
        lon,
      ];
}
