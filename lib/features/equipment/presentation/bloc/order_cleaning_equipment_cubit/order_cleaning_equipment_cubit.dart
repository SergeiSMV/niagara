import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/use_cases/order_cleaning_use_case.dart';

part 'order_cleaning_equipment_state.dart';
part 'order_cleaning_equipment_cubit.freezed.dart';

@injectable
class OrderCleaningEquipmentCubit extends Cubit<OrderCleaningEquipmentState> {
  OrderCleaningEquipmentCubit(
    this._orderCleaningUseCase,
  ) : super(const OrderCleaningEquipmentState.initial());

  final OrderCleaningUseCase _orderCleaningUseCase;

  /// [selectedDate] - выбранная дата
  DateTime? selectedDate;

  /// [comment] - комментарий
  String comment = '';

  /// [selectedTimeSlot] - выбранный временной слот
  TimeSlot? selectedTimeSlot;

  Future<void> orderCleaning({
    required String locationId,
    required int deviceId,
  }) async {
    if (!_validateData()) return;
    final date = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(selectedDate!);
    final timeBegin = formatTimeToISOString(selectedTimeSlot!.timeBegin);
    final timeEnd = formatTimeToISOString(selectedTimeSlot!.timeEnd);

    emit(const OrderCleaningEquipmentState.loading());

    await _orderCleaningUseCase(
      OrderCleaningParams(
        date: date,
        locationId: locationId,
        deviceId: deviceId,
        timeBegin: timeBegin,
        timeEnd: timeEnd,
        comment: comment,
      ),
    ).fold(
      (failure) => emit(const OrderCleaningEquipmentState.error()),
      (result) => result
          ? emit(const OrderCleaningEquipmentState.success())
          : emit(const OrderCleaningEquipmentState.error()),
    );
  }

  bool _validateData() {
    if (selectedDate == null || selectedTimeSlot == null) {
      emit(const OrderCleaningEquipmentState.validateData());
      emit(const OrderCleaningEquipmentState.initial());
      return false;
    } else {
      return true;
    }
  }

  String formatTimeToISOString(String time) {
    final parts = time.split(':');
    final hour = parts[0].padLeft(2, '0');
    final minute = parts[1].padLeft(2, '0');
    return '0001-01-01T$hour:$minute:00';
  }
}
