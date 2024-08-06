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
}
