import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_status_description_use_case.dart';

part 'vip_event.dart';
part 'vip_state.dart';
part 'vip_bloc.freezed.dart';

typedef _Emit = Emitter<VipState>;

@injectable
class VipBloc extends Bloc<VipEvent, VipState> {
  VipBloc(
    this._getStatusDescriptionUseCase,
    this._hasAuthStatusUseCase,
  ) : super(const _Loading()) {
    on<_StartedEvent>(_onStarted);

    add(const _StartedEvent());
  }

  final GetStatusDescriptionUseCase _getStatusDescriptionUseCase;
  final HasAuthStatusUseCase _hasAuthStatusUseCase;

  Future<void> _onStarted(
    _StartedEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());

    // Коллбек, который будет вызван при ошибке.
    void emitError(Failure failure) => emit(_Error(message: failure.error));

    await _hasAuthStatusUseCase.call().fold(
      emitError,
      (hasAuth) async {
        if (!hasAuth) return emit(const _Unauthorized());

        await _getStatusDescriptionUseCase.call(StatusLevel.vip).fold(
              emitError,
              (bonuses) async =>
                  _getStatusDescriptionUseCase.call(bonuses.level).fold(
                        emitError,
                        (description) =>
                            emit(_Loaded(description: description)),
                      ),
            );
      },
    );
  }
}
