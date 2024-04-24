import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/domain/usecases/get_city_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/get_locations_use_case.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'locations_bloc.freezed.dart';
part 'locations_event.dart';
part 'locations_state.dart';

typedef _Emit = Emitter<LocationsState>;

@lazySingleton
class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc({
    required GetLocationsUseCase getLocations,
    required GetCityUseCase getCityUseCase,
  })  : _getLocations = getLocations,
        _getCityUseCase = getCityUseCase,
        super(const _Initial()) {
    on<_LoadLocations>(_onLoadLocations, transformer: debounce());
  }

  final GetLocationsUseCase _getLocations;
  final GetCityUseCase _getCityUseCase;

  Future<void> _onLoadLocations(_LoadLocations event, _Emit emit) async {
    emit(const _Loading());
    final city = await _getCityUseCase().fold((_) => null, (city) => city);

    if (city == null) return emit(const _Error());

    await _getLocations().fold(
      (_) => emit(const _Error()),
      (locations) => emit(_Loaded(city: city, locations: locations)),
    );
  }
}
