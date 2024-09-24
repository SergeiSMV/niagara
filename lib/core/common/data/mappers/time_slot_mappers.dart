import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/data/remote/dto/time_slot_dto.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';

extension TimeSlotMapper on TimeSlotDto {
  TimeSlot toModel() => _ensureFormatted(
        TimeSlot(
          timeBegin: timeBegin,
          timeEnd: timeEnd,
        ),
      );
}

/// Преобразует формат времени из [TimeSlot] в формат, удобный для отображения.
///
/// Обычно с бекенда [TimeSlot] приходит в формате `0001-01-01T00:00:00`, но
/// смысл имеют только часы и минуты.
/// 
/// Если время пришло правильно, ничего не делает.
TimeSlot _ensureFormatted(TimeSlot original) {
  final DateTime? begin = DateTime.tryParse(original.timeBegin);
  final DateTime? end = DateTime.tryParse(original.timeEnd);

  final formatter = DateFormat('HH:mm');

  return TimeSlot(
    timeBegin: begin != null ? formatter.format(begin) : original.timeBegin,
    timeEnd: end != null ? formatter.format(end) : original.timeEnd,
  );
}
