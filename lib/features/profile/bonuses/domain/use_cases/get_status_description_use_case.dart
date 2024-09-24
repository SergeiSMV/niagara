import 'package:niagara_app/core/common/data/database/_imports.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_program_repository.dart';

@injectable
class GetStatusDescriptionUseCase
    extends BaseUseCase<StatusDescription, StatusLevel> {
  GetStatusDescriptionUseCase(this._bonusesRepository);

  final IBonusesProgramRepository _bonusesRepository;

  @override
  Future<Either<Failure, StatusDescription>> call(StatusLevel params) =>
      _bonusesRepository.getStatus(params);
}
