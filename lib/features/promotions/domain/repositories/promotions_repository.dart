import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';

typedef Promotions = ({List<Promotion> promos, Pagination pagination});

abstract interface class IPromotionsRepository {
  Future<Either<Failure, Promotions>> getPromotions({
    required int page,
    required bool isPersonal,
  });
}
