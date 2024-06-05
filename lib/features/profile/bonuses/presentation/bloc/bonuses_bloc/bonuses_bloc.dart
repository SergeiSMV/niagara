import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_bonuses_use_case.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_status_description_use_case.dart';

part 'bonuses_bloc.freezed.dart';
part 'bonuses_event.dart';
part 'bonuses_state.dart';

typedef _Emit = Emitter<BonusesState>;

@injectable
class BonusesBloc extends Bloc<BonusesEvent, BonusesState> {
  BonusesBloc(
    this._hasAuthStatusUseCase,
    this._getBonusesUseCase,
    this._getStatusDescriptionUseCase,
  ) : super(const _Loading()) {
    on<_StartedEvent>(_onStarted);

    // При первом обращении получаем бонусы
    add(const _StartedEvent());
  }

  final HasAuthStatusUseCase _hasAuthStatusUseCase;
  final GetBonusesUseCase _getBonusesUseCase;
  final GetStatusDescriptionUseCase _getStatusDescriptionUseCase;

  Future<void> _onStarted(
    _StartedEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _hasAuthStatusUseCase.call().fold(
      (failure) => emit(_Error(message: failure.error)),
      (hasAuth) async {
        if (!hasAuth) return emit(const _Unauthorized());

        await _getBonusesUseCase.call().fold(
              (failure) => emit(_Error(message: failure.error)),
              (bonuses) async =>
                  _getStatusDescriptionUseCase.call(bonuses.level).fold(
                        (failure) => emit(_Error(message: failure.error)),
                        (statusDescription) => emit(
                          _Loaded(
                            bonuses: bonuses,
                            statusDescription: statusDescription,
                          ),
                        ),
                      ),
            );
      },
    );
  }
}
