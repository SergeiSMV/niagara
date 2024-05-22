import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';
import 'package:niagara_app/features/promotions/domain/repositories/promotions_repository.dart';

@injectable
class GetPromotionsUseCase extends BaseUseCase<List<Promotion>, NoParams> {
  GetPromotionsUseCase(this._promotionsRepository);

  final IPromotionsRepository _promotionsRepository;

  @override
  Future<Either<Failure, List<Promotion>>> call([NoParams? params]) =>
      _promotionsRepository.getPromotions();
}
