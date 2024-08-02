part of 'equipments_bloc.dart';

@freezed
class EquipmentsState with _$EquipmentsState {
  const factory EquipmentsState.loading() = _Loading;

  const factory EquipmentsState.loaded({
    required List<Equipment> equipments,
  }) = _Loaded;

  const factory EquipmentsState.error() = _Error;
}
