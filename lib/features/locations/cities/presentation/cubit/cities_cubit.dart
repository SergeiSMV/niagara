import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';
import 'package:niagara_app/features/locations/cities/domain/use_cases/get_cities_use_case.dart';
import 'package:niagara_app/features/locations/cities/domain/use_cases/set_city_use_case.dart';

part 'cities_cubit.freezed.dart';
part 'cities_state.dart';

@injectable
class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit(
    this._getCitiesUseCase,
    this._setCityUseCase,
  ) : super(const _Initial()) {
    /// При инициализации кубита загружаем список городов
    getCities();
  }

  final GetCitiesUseCase _getCitiesUseCase;
  final SetCityUseCase _setCityUseCase;

  Future<void> getCities() async {
    emit(const CitiesState.loading());
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
    emit(const CitiesState.loading());
    await _setCityUseCase.call(city).fold(
          (_) => emit(const _Error()),
          (_) => emit(_Selected(city: city)),
        );
  }
}
