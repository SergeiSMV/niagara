import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_repository.dart';

@injectable
class GetBonusesUseCase extends BaseUseCase<Bonuses, NoParams> {
  GetBonusesUseCase(this._bonusesRepository);

  final IBonusesRepository _bonusesRepository;

  @override
  Future<Either<Failure, Bonuses>> call([NoParams? params]) =>
      _bonusesRepository.getBonuses();
}
