import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/model/equipment.dart';
import 'package:niagara_app/features/equipment/domain/repositories/equipments_repository.dart';

@injectable
class GetEquipmentsUseCase extends BaseUseCase<List<Equipment>, NoParams> {
  const GetEquipmentsUseCase(this._equipmentsRepository);

  final IEquipmentsRepository _equipmentsRepository;

  @override
  Future<Either<Failure, List<Equipment>>> call([NoParams? params]) async =>
      _equipmentsRepository.getEquipments();
}
