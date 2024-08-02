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
    required this.deviceServiceStatus,
    required this.deviceServiceLastDate,
    required this.deviceServiceNextDate,
    required this.deviceServiceDaysLeft,
  });

  @JsonKey(name: 'LOCATION_ID')
  final String locationId;
  @JsonKey(name: 'LOCATION_NAME')
  final String locationName;
  @JsonKey(name: 'DEVICE_ID')
  final int deviceId;
  @JsonKey(name: 'DEVICE_NAME')
  final String deviceName;
  @JsonKey(name: 'DEVICE_SERVICE_STATUS')
  final String deviceServiceStatus;
  @JsonKey(name: 'DEVICE_SERVICE_LAST_DATE')
  final DateTime deviceServiceLastDate;
  @JsonKey(name: 'DEVICE_SERVICE_NEXT_DATE')
  final DateTime deviceServiceNextDate;
  @JsonKey(name: 'DEVICE_SERVICE_DAYS_LEFT')
  final int deviceServiceDaysLeft;

  factory EquipmentDto.fromJson(Map<String, dynamic> json) =>
      _$EquipmentDtoFromJson(json);

  @override
  List<Object?> get props => [
        locationId,
        locationName,
        deviceId,
        deviceName,
        deviceServiceStatus,
        deviceServiceLastDate,
        deviceServiceNextDate,
        deviceServiceDaysLeft,
      ];
}
