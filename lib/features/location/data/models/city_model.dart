import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class CityModel extends Equatable {
  const CityModel({
    required this.region,
    required this.cityId,
    required this.city,
    required this.lat,
    required this.lon,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  final String region;
  final int cityId;
  final String city;
  @JsonKey(fromJson: double.parse)
  final double lat;
  @JsonKey(fromJson: double.parse, name: 'LAN')
  final double lon;

  @override
  List<Object?> get props => [
        region,
        cityId,
        city,
        lat,
        lon,
      ];
}
