import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/repositories/equipments_repository.dart';

@injectable
class GetAvailableCleaningDatesUseCase
    extends BaseUseCase<List<DateTime>, String> {
  const GetAvailableCleaningDatesUseCase(this._equipmentsRepository);

  final IEquipmentsRepository _equipmentsRepository;

  @override
  Future<Either<Failure, List<DateTime>>> call(String locationId) async =>
      _equipmentsRepository.getAvailableCleaningDates(locationId: locationId);
}
