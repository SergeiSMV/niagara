import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'shop_dto.g.dart';

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

  factory ShopDto.fromJson(Map<String, dynamic> json) =>
      _$ShopDtoFromJson(json);

  @JsonKey(name: 'STORE_ID')
  final String id;

  @JsonKey(name: 'STORE_ADRESS')
  final String address;

  @JsonKey(name: 'STORE_LAT', fromJson: double.parse)
  final double latitude;

  @JsonKey(name: 'STORE_LON', fromJson: double.parse)
  final double longitude;

  @JsonKey(name: 'STORE_DAY')
  final int? storeDay;

  @JsonKey(name: 'STORE_TIME_BEGIN')
  final String? storeTimeBegin;

  @JsonKey(name: 'STORE_TIME_END')
  final String? storeTimeEnd;

  @JsonKey(name: 'STORE_TIME_WORK')
  final List<StoreWorkTime>? workTimes;

  @override
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class StoreWorkTime extends Equatable {
  const StoreWorkTime({
    required this.storeDay,
    required this.storeTimeBegin,
    required this.storeTimeEnd,
  });

  factory StoreWorkTime.fromJson(Map<String, dynamic> json) =>
      _$StoreWorkTimeFromJson(json);

  @JsonKey(name: 'STORE_DAY')
  final int storeDay;

  @JsonKey(name: 'STORE_TIME_BEGIN')
  final String storeTimeBegin;

  @JsonKey(name: 'STORE_TIME_END')
  final String storeTimeEnd;

  @override
  List<Object?> get props => throw UnimplementedError();
}
