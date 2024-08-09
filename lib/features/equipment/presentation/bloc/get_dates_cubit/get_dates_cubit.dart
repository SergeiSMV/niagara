import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/use_cases/get_available_cleaning_dates_use_case.dart';

part 'get_dates_cubit.freezed.dart';
part 'get_dates_state.dart';

@injectable
class GetDatesCubit extends Cubit<GetDatesState> {
  GetDatesCubit(
    this._getAvailableCleaningDatesUseCase,
  ) : super(const GetDatesState.loading());

  final GetAvailableCleaningDatesUseCase _getAvailableCleaningDatesUseCase;

  /// [_firstLoad] Показывает если это первая загрузка,
  /// то после выполнения метода [getDates] вызываем метод получения временных
  /// слотов с первой датой в списке дат из [getDates].
  bool _firstLoad = true;

  Future<void> getDates(String locationId) async {
    emit(const GetDatesState.loading());
    await _getAvailableCleaningDatesUseCase(locationId).fold(
      (failure) => throw failure,
      (dates) {
        dates.isNotEmpty
            ? emit(GetDatesState.loaded(dates, _firstLoad))
            : emit(const GetDatesState.empty());
        _firstLoad = false;
      },
    );
  }
}
