import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_bonuses_use_case.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_status_description_use_case.dart';

part 'vip_description_event.dart';
part 'vip_description_state.dart';
part 'vip_description_bloc.freezed.dart';

typedef _Emit = Emitter<VipState>;

/// BLoC для отображения информации о VIP-статусе.
///
/// Выдает описание программы VIP-подписки и информацию о текущей подписке, если
/// она есть.
@injectable
class VipDescriptionBloc extends Bloc<VipEvent, VipState> {
  VipDescriptionBloc(
    this._getStatusDescriptionUseCase,
    this._getBonusesUseCase,
  ) : super(const _Loading()) {
    on<_StartedEvent>(_onStarted);

    add(const _StartedEvent());
  }

  final GetStatusDescriptionUseCase _getStatusDescriptionUseCase;
  final GetBonusesUseCase _getBonusesUseCase;

  Future<void> _onStarted(
    _StartedEvent event,
    _Emit emit,
  ) async {
    emit(const VipState.loading());

    final Bonuses? bonuses = await _bonuses;
    final StatusDescription? vipDescription = await _vipDescription;

    // Если нет даже описания бонусной программы, выводим ошибку.
    if (vipDescription == null) {
      emit(const VipState.error());
      return;
    }

    String? vipEndDate;

    if (bonuses != null && bonuses.level.isVIPStatus) {
      // Если у пользователя ВИП-статус, то выводим дату окончания подписки.
      vipEndDate = bonuses.endDateFormated;
    }

    emit(
      VipState.loaded(
        description: vipDescription,
        vipEndDate: vipEndDate,
      ),
    );
  }

  /// Возвращает информацию о бонусах пользователя.
  Future<Bonuses?> get _bonuses => _getBonusesUseCase.call().fold(
        (failure) => null,
        (bonuses) => bonuses,
      );

  /// Возвращает описание программы VIP-подписки.
  Future<StatusDescription?> get _vipDescription =>
      _getStatusDescriptionUseCase.call(StatusLevel.vip).fold(
            (failure) => null,
            (description) => description,
          );
}
