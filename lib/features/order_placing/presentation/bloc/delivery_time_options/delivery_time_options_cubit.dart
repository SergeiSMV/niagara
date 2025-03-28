import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/core.dart';
import '../../../domain/models/delivery_time_options.dart';
import '../../../domain/use_cases/get_delivery_time_options_use_case.dart';

part 'delivery_time_options_state.dart';
part 'delivery_time_options_cubit.freezed.dart';

@injectable
class DeliveryTimeOptionsCubit extends Cubit<DeliveryTimeOptionsState> {
  DeliveryTimeOptionsCubit(
    this._getDeliveryTimeOptionsUseCase,
  ) : super(
          const DeliveryTimeOptionsState.loading(),
        );

  final GetDeliveryTimeOptionsUseCase _getDeliveryTimeOptionsUseCase;

  Future<void> getOptions() async {
    emit(const DeliveryTimeOptionsState.loading());
    await _getDeliveryTimeOptionsUseCase(NoParams()).fold(
      (failure) => emit(const DeliveryTimeOptionsState.error()),
      (data) => data.isNotEmpty
          ? emit(DeliveryTimeOptionsState.loaded(data))
          : emit(const DeliveryTimeOptionsState.empty()),
    );
  }
}
