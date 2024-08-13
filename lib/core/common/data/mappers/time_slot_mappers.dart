import 'package:niagara_app/core/common/data/remote/dto/time_slot_dto.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';

extension TimeSlotMapper on TimeSlotDto {
  TimeSlot toModel() => TimeSlot(
        timeBegin: timeBegin,
        timeEnd: timeEnd,
      );
}
