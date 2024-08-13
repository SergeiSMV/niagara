import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/model/equipment.dart';

abstract interface class IEquipmentsRepository {
  /// Метод получения списка оборудования
  Future<Either<Failure, List<Equipment>>> getEquipments();

  /// Метод получения списка доступных дат для заказа чистки оборудования
  /// [locationId] - ID локации оборудования
  Future<Either<Failure, List<DateTime>>> getAvailableCleaningDates({
    required String locationId,
  });

  /// Метод получения списка временных слотов для заказа чистки оборудования
  /// [locationId] - ID локации оборудования
  /// [date] - дата для чистки оборудования
  Future<Either<Failure, List<TimeSlot>>> getTimeSlotsForCleaning({
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
