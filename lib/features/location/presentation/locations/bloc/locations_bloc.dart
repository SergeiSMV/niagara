import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/auth/domain/usecases/has_auth_status.dart';
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

@injectable
class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc({
    required HasAuthStatusUseCase hasAuthStatusUseCase,
    required GetLocationsUseCase getLocations,
    required GetCityUseCase getCityUseCase,
    required AddLocationUseCase addLocationUseCase,
    required UpdateLocationUseCase updateLocationUseCase,
    required DeleteLocationUseCase deleteLocationUseCase,
    required SetDefaultLocationUseCase setDefaultLocationUseCase,
  })  : _hasAuthStatusUseCase = hasAuthStatusUseCase,
        _getLocations = getLocations,
        _getCityUseCase = getCityUseCase,
        _addLocationUseCase = addLocationUseCase,
        _updateLocationUseCase = updateLocationUseCase,
        _deleteLocationUseCase = deleteLocationUseCase,
        _setDefaultLocationUseCase = setDefaultLocationUseCase,
        super(const _Initial()) {
    on<_InitialEvent>(_onInitial);
    on<_LoadLocationsEvent>(_onLoadLocations, transformer: debounce());
    on<_AddLocationEvent>(_onAddLocation);
    on<_UpdateLocationEvent>(_onUpdateLocation);
    on<_DeleteLocationEvent>(_onDeleteLocation);
    on<_SetDefaultLocationEvent>(_onSetDefaultLocation);

    /// При инициализации блока проверяем на авторизацию пользователя
    add(const _InitialEvent());
  }

  final HasAuthStatusUseCase _hasAuthStatusUseCase;
  final GetLocationsUseCase _getLocations;
  final GetCityUseCase _getCityUseCase;
  final AddLocationUseCase _addLocationUseCase;
  final UpdateLocationUseCase _updateLocationUseCase;
  final DeleteLocationUseCase _deleteLocationUseCase;
  final SetDefaultLocationUseCase _setDefaultLocationUseCase;

  Future<void> _onInitial(
    _InitialEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    final city = await _getCity();
    if (city == null) return emit(const _Error());

    await _hasAuthStatusUseCase.call().fold(
          (_) => emit(const _Error()),
          (hasAuth) => hasAuth
              ? add(const _LoadLocationsEvent())
              : emit(_Unauthorized(city: city)),
        );
  }

  Future<void> _onLoadLocations(
    _LoadLocationsEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    final city = await _getCity();
    if (city == null) return emit(const _Error());

    await _getLocations().fold(
      (_) => emit(_Error(city: city)),
      (locations) => emit(_Loaded(city: city, locations: locations)),
    );
  }

  Future<void> _onAddLocation(
    _AddLocationEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _addLocationUseCase(event.location).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadLocationsEvent()),
    );
  }

  Future<void> _onUpdateLocation(
    _UpdateLocationEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _updateLocationUseCase(event.location).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadLocationsEvent()),
    );
  }

  Future<void> _onDeleteLocation(
    _DeleteLocationEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _deleteLocationUseCase(event.location).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadLocationsEvent()),
    );
  }

  Future<void> _onSetDefaultLocation(
    _SetDefaultLocationEvent event,
    _Emit emit,
  ) async {
    final city = await _getCity();
    if (city == null) return emit(const _Error());

    await _setDefaultLocationUseCase(event.location).fold(
      (_) => emit(const _Error()),
      (_) async => _getLocations().fold(
        (_) => emit(_Error(city: city)),
        (locations) => emit(_Loaded(city: city, locations: locations)),
      ),
    );
  }

  Future<City?> _getCity() async => _getCityUseCase().fold(
        (_) => null,
        (city) => city,
      );
}
