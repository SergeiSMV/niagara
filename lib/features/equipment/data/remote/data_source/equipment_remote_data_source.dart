import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/data/remote/dto/equipment_dto.dart';

abstract interface class IEquipmentsRemoteDataSource {
  Future<Either<Failure, List<EquipmentDto>>> getEquipments();
}

@LazySingleton(as: IEquipmentsRemoteDataSource)
class EquipmentsRemoteDataSource implements IEquipmentsRemoteDataSource {
  EquipmentsRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<EquipmentDto>>> getEquipments() =>
      _requestHandler.sendRequest<List<EquipmentDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetDevices,
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(EquipmentDto.fromJson)
            .toList(),
        failure: EquipmentsRemoteDataFailure.new,
      );
}
