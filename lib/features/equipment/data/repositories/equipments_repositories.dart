import 'package:niagara_app/core/common/data/mappers/time_slot_mappers.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/data/mappers/equipment_mapper.dart';
import 'package:niagara_app/features/equipment/data/remote/data_source/equipment_remote_data_source.dart';
import 'package:niagara_app/features/equipment/domain/model/equipment.dart';
import 'package:niagara_app/features/equipment/domain/repositories/equipments_repository.dart';

@LazySingleton(as: IEquipmentsRepository)
class EquipmentsRepositories extends BaseRepository
    implements IEquipmentsRepository {
  EquipmentsRepositories(
    super._logger,
    super._networkInfo,
    this._equipmentsRDS,
  );

  final IEquipmentsRemoteDataSource _equipmentsRDS;

  @override
  Failure get failure => const EquipmentsRepositoryFailure();

  @override
  Future<Either<Failure, List<Equipment>>> getEquipments() => execute(
        () async => await _equipmentsRDS.getEquipments().fold(
              (failure) => throw failure,
              (equipmentDtos) =>
                  equipmentDtos.map((dto) => dto.toModel()).toList(),
            ),
      );

  @override
  Future<Either<Failure, List<DateTime>>> getEquipmentCleaningDate({
    required String locationId,
  }) =>
      execute(
        () async => await _equipmentsRDS
            .getEquipmentCleaningDate(locationId: locationId)
            .fold(
              (failure) => throw failure,
              (dates) => dates,
            ),
      );

  @override
  Future<Either<Failure, List<TimeSlot>>> getTimeSlotsForCleaningEquipment({
    required String locationId,
    required String date,
  }) =>
      execute(
        () async => await _equipmentsRDS
            .getTimeSlotsForCleaningEquipment(
                locationId: locationId, date: date)
            .fold(
              (failure) => throw failure,
              (timeSlotDtos) =>
                  timeSlotDtos.map((dto) => dto.toModel()).toList(),
            ),
      );
}
