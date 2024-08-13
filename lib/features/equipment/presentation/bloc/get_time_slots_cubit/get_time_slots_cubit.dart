import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/use_cases/get_time_slots_for_cleaning_use_case.dart';

part 'get_time_slots_state.dart';
part 'get_time_slots_cubit.freezed.dart';

@injectable
class GetTimeSlotsCubit extends Cubit<GetTimeSlotsState> {
  GetTimeSlotsCubit(
    this._getDeliveryTimeSlotsUseCase,
  ) : super(const GetTimeSlotsState.loading());

  final GetTimeSlotsForCleaningUseCase _getDeliveryTimeSlotsUseCase;

  Future<void> getTimeSlots(String locationId, DateTime date) async {
    emit(const GetTimeSlotsState.loading());
    await _getDeliveryTimeSlotsUseCase(
      DeliveryTimeSlotsParams(
        locationId: locationId,
        date: date,
      ),
    ).fold(
      (failure) => emit(const GetTimeSlotsState.error()),
      (data) => data.isNotEmpty
          ? emit(GetTimeSlotsState.loaded(data))
          : emit(const GetTimeSlotsState.empty()),
    );
  }
}
