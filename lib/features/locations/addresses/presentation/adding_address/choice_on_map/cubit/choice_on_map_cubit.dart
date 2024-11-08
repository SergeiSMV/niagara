// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/address/checking_for_deliverability.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/geocoder/get_address_by_point_use_case.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'choice_on_map_cubit.freezed.dart';
part 'choice_on_map_state.dart';

@injectable
class ChoiceOnMapCubit extends Cubit<ChoiceOnMapState> {
  ChoiceOnMapCubit(
    this._getAddressUseCase,
    this._checkingForDeliverabilityUseCase,
  ) : super(const _Initial());

  final GetAddressByPointUseCase _getAddressUseCase;
  final CheckingForDeliverabilityUseCase _checkingForDeliverabilityUseCase;

  // Получает адрес по координатам
  Future<void> _getAddress({required Point point}) async {
    Address? address;

    // TODO(kvbykov): Почему-то тут either не отработал
    try {
      address = await _getAddressUseCase
          .call(point)
          .fold((_) => null, (address) => address);
    } catch (e, st) {
      print('Error: $e, StackTrace: $st');
    }

    if (address != null) {
      final isAvailableDelivery = await _checkingForDeliverabilityUseCase
          .call(address)
          .fold((_) => false, (isAvailable) => isAvailable);
      return isAvailableDelivery
          ? _emit(_Complete(address: address))
          : _emit(_NoDelivery(address: address));
    }

    _emit(const _NoAddressFound());
  }

  /// Отвечает за обновление адреса при изменении камеры/фокуса
  Future<void> searchAddress({
    required Point point,
    required bool finished,
  }) async {
    // Если камера остановилась, то получаем адрес
    if (finished) await _getAddress(point: point);
  }

  /// Подтверждает адрес и переходит на экран редактирования
  Future<void> onAddendumAddress() async {
    final state = this.state as _Complete;
    _emit(_Approve(address: state.address));
  }

  /// Переходит на экран редактирования адреса
  Future<void> onEditAddress() async {
    final state = this.state as _Approve;
    _emit(_Complete(address: state.address));
  }

  /// Подтверждает адрес
  Future<void> onApproveAddress({required Address address}) async {
    _emit(_Approve(address: address));
  }

  // Устанавливает дефолтное местоположение
  Future<void> setDefaultLocation() async {
    _emit(const _Denied());
  }

  void _emit(ChoiceOnMapState state) {
    if (isClosed) return;
    emit(state);
  }
}
