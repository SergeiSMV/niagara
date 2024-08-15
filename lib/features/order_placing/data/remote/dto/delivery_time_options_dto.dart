// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/common/data/remote/dto/time_slot_dto.dart';
import 'package:niagara_app/core/core.dart';

part 'delivery_time_options_dto.g.dart';

/// DTO объекта, описывающего возможные даты и временные промежутки для доставки.
@JsonSerializable(createToJson: false, fieldRename: FieldRename.screamingSnake)
class DeliveryTimeOptionsDto extends Equatable {
  const DeliveryTimeOptionsDto({
    required this.date,
    required this.timeSlots,
  });

  @JsonKey(name: 'DATE')
  final DateTime date;

  @JsonKey(name: 'TIME')
  final List<TimeSlotDto> timeSlots;

  factory DeliveryTimeOptionsDto.fromJson(Map<String, dynamic> json) =>
      _$DeliveryTimeOptionsDtoFromJson(json);

  @override
  List<Object?> get props => [date, timeSlots];
}
