import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';

abstract interface class IPromotionsRepository {
  Future<Either<Failure, List<Promotion>>> getPromotions();
}
