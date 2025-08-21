import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/core.dart';
import '../../../domain/model/equipment.dart';
import '../../../domain/use_cases/get_equipments_use_case.dart';

part 'equipments_event.dart';
part 'equipments_state.dart';
part 'equipments_bloc.freezed.dart';

typedef _Emit = Emitter<EquipmentsState>;

/// Блок для загрузки оборудования
@injectable
class EquipmentsBloc extends Bloc<EquipmentsEvent, EquipmentsState> {
  EquipmentsBloc(
    this._getEquipmentsUseCase,
  ) : super(const _Loading()) {
    on<_GetEquipments>(_getEquipments);

    add(const _GetEquipments());
  }

  /// Кейс для загрузки оборудования
  final GetEquipmentsUseCase _getEquipmentsUseCase;

  /// Загрузка оборудования
  Future<void> _getEquipments(
    _GetEquipments event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _getEquipmentsUseCase().fold(
      (failure) => throw failure,
      (equipments) => emit(_Loaded(equipments: equipments)),
    );
  }
}
