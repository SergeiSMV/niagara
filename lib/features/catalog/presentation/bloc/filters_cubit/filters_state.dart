part of 'filters_cubit.dart';

@freezed
class FiltersState with _$FiltersState {
  const factory FiltersState.loading() = _Loading;

  const factory FiltersState.loaded({
    required List<Filter> filters,
    required List<FilterProperty> selectedFilters,
  }) = _Loaded;

  const factory FiltersState.error() = _Error;
}
