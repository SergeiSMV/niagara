import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses_program.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_program_repository.dart';

@injectable
class GetBonusesProgramUseCase extends BaseUseCase<BonusesProgram, NoParams> {
  GetBonusesProgramUseCase(this._bonusesRepository);

  final IBonusesProgramRepository _bonusesRepository;

  @override
  Future<Either<Failure, BonusesProgram>> call([NoParams? params]) =>
      _bonusesRepository.getBonusesProgram();
}
