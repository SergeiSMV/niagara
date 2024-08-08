import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/repositories/equipments_repository.dart';

@injectable
class GetEquipmentCleaningDateUseCase
    extends BaseUseCase<List<DateTime>, String> {
  const GetEquipmentCleaningDateUseCase(this._equipmentsRepository);

  final IEquipmentsRepository _equipmentsRepository;

  @override
  Future<Either<Failure, List<DateTime>>> call(String locationId) async =>
      _equipmentsRepository.getEquipmentCleaningDate(locationId: locationId);
}
