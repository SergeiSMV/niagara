import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/model/equipment.dart';

abstract interface class IEquipmentsRepository {
  Future<Either<Failure, List<Equipment>>> getEquipments();

  Future<Either<Failure, List<DateTime>>> getEquipmentCleaningDate({
    required String locationId,
  });

  Future<Either<Failure, List<TimeSlot>>> getTimeSlotsForCleaningEquipment({
    required String locationId,
    required String date,
  });
}
