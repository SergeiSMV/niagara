import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/repositories/equipments_repository.dart';

@injectable
class GetTimeSlotsForCleaningEquipmentUseCase
    extends BaseUseCase<List<TimeSlot>, DeliveryTimeSlotsParams> {
  const GetTimeSlotsForCleaningEquipmentUseCase(this._equipmentsRepository);

  final IEquipmentsRepository _equipmentsRepository;

  @override
  Future<Either<Failure, List<TimeSlot>>> call(
    DeliveryTimeSlotsParams params,
  ) async =>
      _equipmentsRepository.getTimeSlotsForCleaningEquipment(
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
  final String date;

  @override
  List<Object?> get props => [
        locationId,
        date,
      ];
}
