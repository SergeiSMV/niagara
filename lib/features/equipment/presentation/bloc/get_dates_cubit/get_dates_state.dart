part of 'get_dates_cubit.dart';

@freezed
class GetDatesState with _$GetDatesState {
  const factory GetDatesState.loading() = _Loading;
  const factory GetDatesState.loaded(
    List<DateTime> dates,
    bool firstLoad,
  ) = _Loaded;
  const factory GetDatesState.error() = _Error;
  const factory GetDatesState.empty() = _Empty;
}
