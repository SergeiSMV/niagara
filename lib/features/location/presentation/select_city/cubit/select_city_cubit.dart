import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/domain/usecases/get_cities_use_case.dart';

part 'select_city_cubit.freezed.dart';
part 'select_city_state.dart';

@injectable
class SelectCityCubit extends Cubit<SelectCityState> {
  SelectCityCubit({
    required GetCitiesUseCase getCitiesUseCase,
  })  : _getCitiesUseCase = getCitiesUseCase,
        super(const SelectCityState.initial());

  final GetCitiesUseCase _getCitiesUseCase;

  Future<void> getCities() async {
    emit(const SelectCityState.loading());
    final result = await _getCitiesUseCase();
    result.fold(
      (_) => emit(const SelectCityState.error()),
      (cities) => emit(
        SelectCityState.loaded(
          cities: cities..sort((a, b) => a.name.compareTo(b.name)),
        ),
      ),
    );
  }
}
