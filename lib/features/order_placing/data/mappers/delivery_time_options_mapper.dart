import 'package:niagara_app/core/common/data/mappers/time_slot_mappers.dart';
import 'package:niagara_app/features/order_placing/data/remote/dto/delivery_time_options_dto.dart';
import 'package:niagara_app/features/order_placing/domain/models/delivery_time_options.dart';

extension DeliveryTimeOptionsMapper on DeliveryTimeOptionsDto {
  DeliveryTimeOptions toModel() => DeliveryTimeOptions(
        date: date,
        timeSlots: timeSlots.map((e) => e.toModel()).toList(),
      );
}
