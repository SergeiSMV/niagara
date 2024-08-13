import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'time_slot_dto.g.dart';

@JsonSerializable(createToJson: false)
class TimeSlotDto extends Equatable {
  const TimeSlotDto({
    required this.timeBegin,
    required this.timeEnd,
  });

  @JsonKey(name: 'TIME_BEGIN')
  final String timeBegin;
  @JsonKey(name: 'TIME_END')
  final String timeEnd;

  factory TimeSlotDto.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotDtoFromJson(json);

  @override
  List<Object?> get props => [
        timeBegin,
        timeEnd,
      ];
}
