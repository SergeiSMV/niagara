// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'equipment_dto.g.dart';

@JsonSerializable(createToJson: false)
class EquipmentDto extends Equatable {
  const EquipmentDto({
    required this.locationId,
    required this.locationName,
    required this.deviceId,
    required this.deviceName,
    required this.deviceImage,
    required this.deviceServiceStatus,
    required this.deviceServiceLastDate,
    required this.deviceServiceNextDate,
    required this.deviceServiceDaysLeft,
    required this.deviceServiceOrderData,
    required this.deviceServiceOrderTimeBegin,
    required this.deviceServiceOrderTimeEnd,
  });

  @JsonKey(name: 'LOCATION_ID')
  final String locationId;
  @JsonKey(name: 'LOCATION_NAME')
  final String locationName;
  @JsonKey(name: 'DEVICE_ID')
  final int deviceId;
  @JsonKey(name: 'DEVICE_NAME')
  final String deviceName;
  @JsonKey(name: 'DEVICE_IMAGE')
  final String deviceImage;
  @JsonKey(name: 'DEVICE_SERVICE_STATUS')
  final String deviceServiceStatus;
  @JsonKey(name: 'DEVICE_SERVICE_LAST_DATE')
  final DateTime deviceServiceLastDate;
  @JsonKey(name: 'DEVICE_SERVICE_NEXT_DATE')
  final DateTime deviceServiceNextDate;
  @JsonKey(name: 'DEVICE_SERVICE_DAYS_LEFT')
  final int deviceServiceDaysLeft;
  @JsonKey(name: 'DEVICE_SERVICE_ORDER_DATA')
  final DateTime deviceServiceOrderData;
  @JsonKey(name: 'DEVICE_SERVICE_ORDER_TIME_BEGIN')
  final DateTime deviceServiceOrderTimeBegin;
  @JsonKey(name: 'DEVICE_SERVICE_ORDER_TIME_END')
  final DateTime deviceServiceOrderTimeEnd;

  factory EquipmentDto.fromJson(Map<String, dynamic> json) =>
      _$EquipmentDtoFromJson(json);

  @override
  List<Object?> get props => [
        locationId,
        locationName,
        deviceId,
        deviceName,
        deviceImage,
        deviceServiceStatus,
        deviceServiceLastDate,
        deviceServiceNextDate,
        deviceServiceDaysLeft,
        deviceServiceOrderData,
        deviceServiceOrderTimeBegin,
        deviceServiceOrderTimeEnd,
      ];
}
