import 'package:niagara_app/core/common/data/remote/dto/time_slot_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/data/remote/dto/equipment_dto.dart';

abstract interface class IEquipmentsRemoteDataSource {
  Future<Either<Failure, List<EquipmentDto>>> getEquipments();

  Future<Either<Failure, List<DateTime>>> getEquipmentCleaningDate({
    required String locationId,
  });

  Future<Either<Failure, List<TimeSlotDto>>> getTimeSlotsForCleaningEquipment({
    required String locationId,
    required String date,
  });
}

@LazySingleton(as: IEquipmentsRemoteDataSource)
class EquipmentsRemoteDataSource implements IEquipmentsRemoteDataSource {
  EquipmentsRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<EquipmentDto>>> getEquipments() =>
      _requestHandler.sendRequest<List<EquipmentDto>, List<dynamic>>(
        request: (dio) => dio.get(ApiConst.kGetEquipments),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(EquipmentDto.fromJson)
            .toList(),
        failure: EquipmentsRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<DateTime>>> getEquipmentCleaningDate({
    required String locationId,
  }) =>
      _requestHandler.sendRequest<List<DateTime>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetNearestEquipmentCleaningDate,
          queryParameters: {
            'location': locationId,
          },
        ),
        converter: (json) =>
            json.map((e) => DateTime.parse(e as String)).toList(),
        failure: EquipmentsRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<TimeSlotDto>>> getTimeSlotsForCleaningEquipment({
    required String locationId,
    required String date,
  }) =>
      _requestHandler.sendRequest<List<TimeSlotDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetTimeSlotsForCleaningEquipment,
          queryParameters: {
            'location': locationId,
            'date': date,
          },
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(TimeSlotDto.fromJson)
            .toList(),
        failure: EquipmentsRemoteDataFailure.new,
      );
}
