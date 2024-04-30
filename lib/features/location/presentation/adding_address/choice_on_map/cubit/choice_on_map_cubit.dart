// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/domain/usecases/geocoder/get_address_use_case.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'choice_on_map_cubit.freezed.dart';
part 'choice_on_map_state.dart';

@injectable
class ChoiceOnMapCubit extends Cubit<ChoiceOnMapState> {
  ChoiceOnMapCubit({
    required GetAddressUseCase getAddressUseCase,
  })  : _getAddressUseCase = getAddressUseCase,
        super(const _Initial());

  final GetAddressUseCase _getAddressUseCase;

  // Получает адрес по координатам
  Future<void> _getAddress({required Point point}) async {
    await _getAddressUseCase.call(point).fold(
          (_) => _emit(const _NoAddressFound()),
          (location) => _emit(_Complete(location: location)),
        );
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
    _emit(_Approve(location: state.location));
  }

  /// Переходит на экран редактирования адреса
  Future<void> onEditAddress() async {
    final state = this.state as _Approve;
    _emit(_Complete(location: state.location));
  }

  /// Подтверждает адрес
  Future<void> onApproveAddress({required Location location}) async {
    _emit(_Approve(location: location));
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
