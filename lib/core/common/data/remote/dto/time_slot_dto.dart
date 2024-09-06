// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'time_slot_dto.g.dart';

/// DTO-объект для парсинга временного интервала.
///
/// Содержит информацию о времени начала и окончания интервала.
///
/// Время в формате `0001-01-01T17:00:00`. Часть до `T` всегда одинакова и не
/// имеет значения.
@JsonSerializable(createToJson: false, fieldRename: FieldRename.screamingSnake)
class TimeSlotDto extends Equatable {
  const TimeSlotDto({
    required this.timeBegin,
    required this.timeEnd,
  });

  final String timeBegin;
  final String timeEnd;

  factory TimeSlotDto.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotDtoFromJson(json);

  @override
  List<Object?> get props => [
        timeBegin,
        timeEnd,
      ];
}
