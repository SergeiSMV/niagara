import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/data/remote/dto/time_slot_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/data/remote/dto/equipment_dto.dart';

abstract interface class IEquipmentsRemoteDataSource {
  /// Метод получения списка оборудования
  Future<Either<Failure, List<EquipmentDto>>> getEquipments();

  /// Метод получения даты очистки оборудования
  /// [locationId] - ID локации оборудования
  Future<Either<Failure, List<DateTime>>> getAvailableCleaningDates({
    required String locationId,
  });

  /// Метод получения списка временных слотов для заказа чистки оборудования
  /// [locationId] - ID локации оборудования
  /// [date] - дата очистки
  Future<Either<Failure, List<TimeSlotDto>>> getTimeSlotsForCleaning({
    required String locationId,
    required DateTime date,
  });

  /// Метод оформления заказа чистки
  /// [date] - дата очистки
  /// [locationId] - ID локации оборудования
  /// [deviceId] - ID оборудования
  /// [timeBegin] - время начала очистки
  /// [timeEnd] - время окончания очистки
  /// [comment] - комментарий
  Future<Either<Failure, bool>> orderCleaning({
    required String date,
    required String locationId,
    required int deviceId,
    required String timeBegin,
    required String timeEnd,
    required String comment,
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
  Future<Either<Failure, List<DateTime>>> getAvailableCleaningDates({
    required String locationId,
  }) =>
      _requestHandler.sendRequest<List<DateTime>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetCleaningDateRange,
          queryParameters: {
            'location': locationId,
          },
        ),
        converter: (json) =>
            json.map((e) => DateTime.parse(e as String)).toList(),
        failure: EquipmentsRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<TimeSlotDto>>> getTimeSlotsForCleaning({
    required String locationId,
    required DateTime date,
  }) {
    final params = {
      'id_location': locationId,
      'date': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(date),
    };

    return _requestHandler.sendRequest<List<TimeSlotDto>, List<dynamic>>(
      request: (dio) => dio.get(
        ApiConst.kGetTimeSlotsForCleaning,
        queryParameters: params,
      ),
      converter: (json) => json
          .map((e) => e as Map<String, dynamic>)
          .toList()
          .map(TimeSlotDto.fromJson)
          .toList(),
      failure: EquipmentsRemoteDataFailure.new,
    );
  }

  @override
  Future<Either<Failure, bool>> orderCleaning({
    required String date,
    required String locationId,
    required int deviceId,
    required String timeBegin,
    required String timeEnd,
    required String comment,
  }) =>
      _requestHandler.sendRequest<bool, bool>(
        request: (dio) => dio.post(
          ApiConst.kOrderCleaning,
          data: {
            'DATE': date,
            'LOCATION': locationId,
            'DEVICE': deviceId,
            'TIME_BEGIN': timeBegin,
            'TIME_END': timeEnd,
            'DESCRIPTION': comment,
          },
        ),
        converter: (result) => result,
        failure: EquipmentsRemoteDataFailure.new,
      );
}
