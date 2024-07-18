import 'package:niagara_app/features/order_history/data/remote/dto/order_evaluation_option_dto.dart';
import 'package:niagara_app/features/order_history/domain/models/order_evaluation_option.dart';

extension OrderEvaluationOptionDtoMapper on OrderEvaluationOptionDto {
  OrderEvaluationOption toModel() => OrderEvaluationOption(
        id: id,
        name: name,
      );
}
