// ignore_for_file: sort_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'shop_dto.g.dart';

// ! ВАЖНО: Перепутаны координаты на бэке! 

/// DTO для магазина с удаленного сервера.
@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class ShopDto extends Equatable {
  const ShopDto({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.storeDay,
    required this.storeTimeBegin,
    required this.storeTimeEnd,
    this.workTimes,
  });

  @JsonKey(name: 'STORE_ID', fromJson: int.parse)
  final int id;

  @JsonKey(name: 'STORE_ADRESS')
  final String address;

  @JsonKey(name: 'STORE_LON', fromJson: _getCoordinate)
  final double latitude;

  @JsonKey(name: 'STORE_LAT', fromJson: _getCoordinate)
  final double longitude;

  @JsonKey(name: 'STORE_DAY')
  final int? storeDay;

  @JsonKey(name: 'STORE_TIME_BEGIN')
  final String? storeTimeBegin;

  @JsonKey(name: 'STORE_TIME_END')
  final String? storeTimeEnd;

  @JsonKey(name: 'STORE_TIME_WORK')
  final List<StoreWorkTimeDto>? workTimes;

  factory ShopDto.fromJson(Map<String, dynamic> json) =>
      _$ShopDtoFromJson(json);

  static double _getCoordinate(String value) =>
      double.parse(value.replaceAll(',', '.'));

  @override
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class StoreWorkTimeDto extends Equatable {
  const StoreWorkTimeDto({
    required this.storeDay,
    required this.storeTimeBegin,
    required this.storeTimeEnd,
  });

  factory StoreWorkTimeDto.fromJson(Map<String, dynamic> json) =>
      _$StoreWorkTimeDtoFromJson(json);

  @JsonKey(name: 'STORE_DAY')
  final int storeDay;

  @JsonKey(name: 'STORE_TIME_BEGIN')
  final String storeTimeBegin;

  @JsonKey(name: 'STORE_TIME_END')
  final String storeTimeEnd;

  @override
  List<Object?> get props => throw UnimplementedError();
}
