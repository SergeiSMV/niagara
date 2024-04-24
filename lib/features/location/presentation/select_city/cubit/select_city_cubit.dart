import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/domain/usecases/get_cities_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/set_city_use_case.dart';

part 'select_city_cubit.freezed.dart';
part 'select_city_state.dart';

@injectable
class SelectCityCubit extends Cubit<SelectCityState> {
  SelectCityCubit({
    required GetCitiesUseCase getCitiesUseCase,
    required SetCityUseCase setCityUseCase,
  })  : _getCitiesUseCase = getCitiesUseCase,
        _setCityUseCase = setCityUseCase,
        super(const _Initial());

  final GetCitiesUseCase _getCitiesUseCase;
  final SetCityUseCase _setCityUseCase;

  Future<void> getCities() async {
    emit(const SelectCityState.loading());
    final result = await _getCitiesUseCase();
    result.fold(
      (_) => emit(const _Error()),
      (cities) => emit(
        _Loaded(
          cities: cities..sort((a, b) => a.name.compareTo(b.name)),
        ),
      ),
    );
  }

  Future<void> selectCity(City city) async {
    emit(const SelectCityState.loading());
    await _setCityUseCase.call(city).fold(
          (_) => emit(const _Error()),
          (_) => emit(_Selected(city: city)),
        );
  }
}
