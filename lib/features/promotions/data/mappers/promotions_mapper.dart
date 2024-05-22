import 'package:niagara_app/features/promotions/data/remote/dto/promotion_dto.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';

extension PromotionsMapper on PromotionDto {
  Promotion toModel() => Promotion(
        title: offersName ?? '',
        description: offersDescription ?? '',
        image: offersImage ?? '',
        endDate: offersDateEnd,
      );
}
