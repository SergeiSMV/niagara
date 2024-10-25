import 'package:niagara_app/features/promotions/data/remote/dto/promotion_dto.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';

extension PromotionsMapper on PromotionDto {
  Promotion toModel() => Promotion(
        id: id ?? '',
        title: name ?? '',
        description: description ?? '',
        image: image ?? '',
        startDate: DateTime.parse(dateBegin ?? ''),
        endDate: DateTime.parse(dateEnd ?? ''),
        isPersonal: personal ?? false,
        groupId: groupId?.isNotEmpty == true ? groupId : null,
      );
}
