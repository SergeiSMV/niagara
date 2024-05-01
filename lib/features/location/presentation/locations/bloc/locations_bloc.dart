import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/location/domain/models/city.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/domain/usecases/cities/get_city_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/locations/add_location_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/locations/delete_location_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/locations/get_locations_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/locations/set_default_location_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/locations/update_location_use_case.dart';
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
    required AddLocationUseCase addLocationUseCase,
    required UpdateLocationUseCase updateLocationUseCase,
    required DeleteLocationUseCase deleteLocationUseCase,
    required SetDefaultLocationUseCase setDefaultLocationUseCase,
  })  : _getLocations = getLocations,
        _getCityUseCase = getCityUseCase,
        _addLocationUseCase = addLocationUseCase,
        _updateLocationUseCase = updateLocationUseCase,
        _deleteLocationUseCase = deleteLocationUseCase,
        _setDefaultLocationUseCase = setDefaultLocationUseCase,
        super(const _Initial()) {
    on<_LoadLocations>(_onLoadLocations, transformer: debounce());
    on<_AddLocation>(_onAddLocation);
    on<_UpdateLocation>(_onUpdateLocation);
    on<_DeleteLocation>(_onDeleteLocation);
    on<_SetDefaultLocation>(_onSetDefaultLocation);

    /// При инициализации блока загружаем список локаций
    add(const _LoadLocations());
  }

  final GetLocationsUseCase _getLocations;
  final GetCityUseCase _getCityUseCase;
  final AddLocationUseCase _addLocationUseCase;
  final UpdateLocationUseCase _updateLocationUseCase;
  final DeleteLocationUseCase _deleteLocationUseCase;
  final SetDefaultLocationUseCase _setDefaultLocationUseCase;

  Future<void> _onLoadLocations(
    _LoadLocations event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    final city = await _getCityUseCase().fold((_) => null, (city) => city);

    if (city == null) return emit(const _Error());

    await _getLocations().fold(
      (_) => emit(_Error(city: city)),
      (locations) => emit(_Loaded(city: city, locations: locations)),
    );
  }

  Future<void> _onAddLocation(
    _AddLocation event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _addLocationUseCase(event.location).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadLocations()),
    );
  }

  Future<void> _onUpdateLocation(
    _UpdateLocation event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _updateLocationUseCase(event.location).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadLocations()),
    );
  }

  Future<void> _onDeleteLocation(
    _DeleteLocation event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _deleteLocationUseCase(event.location).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadLocations()),
    );
  }

  Future<void> _onSetDefaultLocation(
    _SetDefaultLocation event,
    _Emit emit,
  ) async {
    final city = await _getCityUseCase().fold((_) => null, (city) => city);

    if (city == null) return emit(const _Error());

    await _setDefaultLocationUseCase(event.location).fold(
      (_) => emit(const _Error()),
      (_) async => _getLocations().fold(
        (_) => emit(_Error(city: city)),
        (locations) => emit(_Loaded(city: city, locations: locations)),
      ),
    );
  }
}
