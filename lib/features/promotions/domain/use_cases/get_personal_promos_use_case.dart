import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/domain/repositories/promotions_repository.dart';

@injectable
class GetPersonalPromosUseCase extends BaseUseCase<Promotions, int> {
  GetPersonalPromosUseCase(this._promotionsRepository);

  final IPromotionsRepository _promotionsRepository;

  @override
  Future<Either<Failure, Promotions>> call(int params) =>
      _promotionsRepository.getPromotions(
        page: params,
        isPersonal: true,
      );
}
