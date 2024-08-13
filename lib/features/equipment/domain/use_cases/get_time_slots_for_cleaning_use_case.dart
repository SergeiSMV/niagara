import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/repositories/equipments_repository.dart';

@injectable
class GetTimeSlotsForCleaningUseCase
    extends BaseUseCase<List<TimeSlot>, DeliveryTimeSlotsParams> {
  const GetTimeSlotsForCleaningUseCase(this._equipmentsRepository);

  final IEquipmentsRepository _equipmentsRepository;

  @override
  Future<Either<Failure, List<TimeSlot>>> call(
    DeliveryTimeSlotsParams params,
  ) async =>
      _equipmentsRepository.getTimeSlotsForCleaning(
        locationId: params.locationId,
        date: params.date,
      );
}

class DeliveryTimeSlotsParams extends Equatable {
  const DeliveryTimeSlotsParams({
    required this.locationId,
    required this.date,
  });
  final String locationId;
  final DateTime date;

  @override
  List<Object?> get props => [
        locationId,
        date,
      ];
}
