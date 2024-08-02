import 'package:niagara_app/core/utils/enums/cleaning_statuses.dart';
import 'package:niagara_app/features/equipment/data/remote/dto/equipment_dto.dart';
import 'package:niagara_app/features/equipment/domain/model/equipment.dart';

extension GroupMapperDto on EquipmentDto {
  Equipment toModel() => Equipment(
        locationId: locationId,
        locationName: locationName,
        id: deviceId,
        name: deviceName,
        status: CleaningStatuses.toEnum(deviceServiceStatus),
        serviceLastDate: deviceServiceLastDate,
        serviceNextDate: deviceServiceNextDate,
        serviceDaysLeft: deviceServiceDaysLeft,
      );
}
