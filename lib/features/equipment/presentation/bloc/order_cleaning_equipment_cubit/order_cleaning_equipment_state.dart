part of 'order_cleaning_equipment_cubit.dart';

@freezed
class OrderCleaningEquipmentState with _$OrderCleaningEquipmentState {
  const factory OrderCleaningEquipmentState.initial() = _Initial;

  const factory OrderCleaningEquipmentState.loading() = _Loading;

  const factory OrderCleaningEquipmentState.success() = _Success;

  const factory OrderCleaningEquipmentState.error() = _Error;

  const factory OrderCleaningEquipmentState.validateData() = _ValidateData;
}
