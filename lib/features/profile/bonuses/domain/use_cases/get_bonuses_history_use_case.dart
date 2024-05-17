import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_repository.dart';

@injectable
class GetBonusesHistoryUseCase extends BaseUseCase<BonusesHistory, int> {
  GetBonusesHistoryUseCase(this._bonusesRepository);

  final IBonusesRepository _bonusesRepository;

  @override
  Future<Either<Failure, BonusesHistory>> call(int params) =>
      _bonusesRepository.getHistory(page: params);
}
