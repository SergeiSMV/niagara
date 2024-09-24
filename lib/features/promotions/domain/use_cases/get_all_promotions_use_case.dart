import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/domain/repositories/promotions_repository.dart';

@injectable
class GetAllPromotionsUseCase extends BaseUseCase<Promotions, int> {
  GetAllPromotionsUseCase(this._promotionsRepository);

  final IPromotionsRepository _promotionsRepository;

  @override
  Future<Either<Failure, Promotions>> call(int params) =>
      _promotionsRepository.getPromotions(
        page: params,
        isPersonal: false,
      );
}
