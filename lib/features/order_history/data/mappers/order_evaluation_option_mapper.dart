import 'package:niagara_app/features/order_history/data/remote/dto/order_rate_option_dto.dart';
import 'package:niagara_app/features/order_history/domain/models/order_rate_option.dart';

extension OrderRateOptionDtoMapper on OrderRateOptionDto {
  OrderRateOption toModel() => OrderRateOption(
        id: id,
        name: name,
      );
}
