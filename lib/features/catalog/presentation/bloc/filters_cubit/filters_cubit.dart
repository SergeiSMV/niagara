import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/domain/model/filter.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/use_cases/get_filters_use_case.dart';

part 'filters_cubit.freezed.dart';
part 'filters_state.dart';

@injectable
class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit(
    this._getFiltersUseCase, {
    @factoryParam required Group group,
  })  : _group = group,
        super(const FiltersState.loading()) {
    loadFilters();
  }

  final GetFiltersUseCase _getFiltersUseCase;

  final Group _group;
  Group get group => _group;

  Future<void> loadFilters() async {
    _emit(const FiltersState.loading());

    final filters = await _getFiltersUseCase.call(_group).fold(
          (failure) => throw failure,
          (data) => data,
        );

    _emit(
      FiltersState.loaded(
        filters: filters,
        selectedFilters: [],
      ),
    );
  }

  Future<void> onToggleFilter(FilterProperty property) async {
    final filters = state.maybeWhen(
      loaded: (filters, _) => filters,
      orElse: () => <Filter>[],
    );
    final selectedFilters = state.maybeWhen(
      loaded: (_, selectedFilters) => selectedFilters,
      orElse: () => <FilterProperty>[],
    );

    final hasFilter = selectedFilters.contains(property);

    final newFilters = hasFilter
        ? selectedFilters.where((e) => e != property).toList()
        : [...selectedFilters, property];

    _emit(
      FiltersState.loaded(
        filters: filters,
        selectedFilters: newFilters,
      ),
    );
  }

  Future<void> onClearFilters() async {
    final filters = state.maybeWhen(
      loaded: (filters, _) => filters,
      orElse: () => <Filter>[],
    );

    _emit(
      FiltersState.loaded(
        filters: filters,
        selectedFilters: [],
      ),
    );
  }

  void _emit(FiltersState state) {
    if (isClosed) return;
    emit(state);
  }
}
