import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/domain/usecases/get_city_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/get_locations_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/set_city_use_case.dart';

part 'locations_bloc.freezed.dart';
part 'locations_event.dart';
part 'locations_state.dart';

typedef _Emit = Emitter<LocationsState>;

@lazySingleton
class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc({
    required GetLocationsUseCase getLocations,
    required SetCityUseCase setCityUseCase,
    required GetCityUseCase getCityUseCase,
  })  : _getLocations = getLocations,
        _setCityUseCase = setCityUseCase,
        _getCityUseCase = getCityUseCase,
        super(const _Initial()) {
    on<_LoadLocations>(_onLoadLocations, transformer: debounce());
    on<_SelectCity>(_onSelectCity);
  }

  final GetLocationsUseCase _getLocations;
  final SetCityUseCase _setCityUseCase;
  final GetCityUseCase _getCityUseCase;

  Future<void> _onLoadLocations(_LoadLocations event, _Emit emit) async {
    emit(const _Loading());
    final city = await _getCityUseCase().fold((_) => null, (city) => city);

    if (city == null) {
      emit(const _Error());
      return;
    }

    await _getLocations().fold(
      (_) => emit(const _Error()),
      (locations) => emit(_Loaded(city: city, locations: locations)),
    );
  }

  Future<void> _onSelectCity(_SelectCity event, _Emit emit) async {
    emit(const _Loading());
    await _setCityUseCase.call(event.city);
    await _onLoadLocations(const _LoadLocations(), emit);
  }
}
