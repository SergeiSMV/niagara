import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/address/add_address_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/address/delete_address_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/address/set_default_address_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/address/update_address_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/get_addresses_use_case.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';
import 'package:niagara_app/features/locations/cities/domain/use_cases/get_city_use_case.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'addresses_bloc.freezed.dart';
part 'addresses_event.dart';
part 'addresses_state.dart';

typedef _Emit = Emitter<AddressesState>;

@lazySingleton
class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc(
    this._hasAuthStatusUseCase,
    this._getCityUseCase,
    this._getAddressesUseCase,
    this._addAddressUseCase,
    this._updateAddressUseCase,
    this._deleteAddressUseCase,
    this._setDefaultAddressUseCase,
  ) : super(const _Initial()) {
    on<_InitialEvent>(_onInitial);
    on<_LoadAddressesEvent>(_onLoadAddresses, transformer: debounce());
    on<_AddAddressEvent>(_onAddAddress);
    on<_UpdateAddressEvent>(_onUpdateAddress);
    on<_DeleteAddressEvent>(_onDeleteAddress);
    on<_SetDefaultAddressEvent>(_onSetDefaultAddress);

    /// При инициализации блока проверяем на авторизацию пользователя
    add(const _InitialEvent());
  }

  final HasAuthStatusUseCase _hasAuthStatusUseCase;
  final GetCityUseCase _getCityUseCase;
  final GetAddressesUseCase _getAddressesUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final SetDefaultAddressUseCase _setDefaultAddressUseCase;

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
              ? add(const _LoadAddressesEvent())
              : emit(_Unauthorized(city: city)),
        );
  }

  Future<void> _onLoadAddresses(
    _LoadAddressesEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    final city = await _getCity();
    if (city == null) return emit(const _Error());

    await _getAddressesUseCase().fold(
      (_) => emit(_Error(city: city)),
      (addresses) => emit(_Loaded(city: city, address: addresses)),
    );
  }

  Future<void> _onAddAddress(
    _AddAddressEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _addAddressUseCase(event.address).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadAddressesEvent()),
    );
  }

  Future<void> _onUpdateAddress(
    _UpdateAddressEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _updateAddressUseCase(event.address).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadAddressesEvent()),
    );
  }

  Future<void> _onDeleteAddress(
    _DeleteAddressEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _deleteAddressUseCase(event.address).fold(
      (_) => emit(const _Error()),
      (_) => add(const _LoadAddressesEvent()),
    );
  }

  Future<void> _onSetDefaultAddress(
    _SetDefaultAddressEvent event,
    _Emit emit,
  ) async {
    final city = await _getCity();
    if (city == null) return emit(const _Error());

    await _setDefaultAddressUseCase(event.address).fold(
      (_) => emit(const _Error()),
      (_) async => _getAddressesUseCase().fold(
        (_) => emit(_Error(city: city)),
        (addresses) => emit(_Loaded(city: city, address: addresses)),
      ),
    );
  }

  Future<City?> _getCity() async => _getCityUseCase().fold(
        (_) => null,
        (city) => city,
      );
}
