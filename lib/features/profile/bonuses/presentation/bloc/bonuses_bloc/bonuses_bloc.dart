import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../../core/core.dart';
import '../../../../../../core/utils/enums/auth_status.dart';
import '../../../../../authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import '../../../domain/models/bonuses.dart';
import '../../../domain/models/status_description.dart';
import '../../../domain/use_cases/get_bonuses_use_case.dart';
import '../../../domain/use_cases/get_status_description_use_case.dart';

part 'bonuses_bloc.freezed.dart';
part 'bonuses_event.dart';
part 'bonuses_state.dart';

typedef _Emit = Emitter<BonusesState>;

/// Блок для загрузки бонусов
@injectable
class BonusesBloc extends Bloc<BonusesEvent, BonusesState> {
  BonusesBloc(
    this._hasAuthStatusUseCase,
    this._getBonusesUseCase,
    this._getStatusDescriptionUseCase,
    this._authStatusStream,
  ) : super(const _Loading()) {
    _authStatusSubscription = _authStatusStream.listen(_onAuthStatusChanged);

    on<_StartedEvent>(_onStarted);

    // При первом обращении получаем бонусы
    add(const _StartedEvent());
  }

  /// Кейс для проверки статуса авторизации
  final HasAuthStatusUseCase _hasAuthStatusUseCase;

  /// Кейс для загрузки бонусов
  final GetBonusesUseCase _getBonusesUseCase;

  /// Кейс для получения описания статуса
  final GetStatusDescriptionUseCase _getStatusDescriptionUseCase;

  /// [Stream] статуса авторизации
  final Stream<AuthenticatedStatus> _authStatusStream;

  /// Подписка на изменение статуса авторизации.
  StreamSubscription? _authStatusSubscription;

  /// Когда изменяется состояние авторизации, происходит запрос на бонусы.
  void _onAuthStatusChanged(AuthenticatedStatus status) =>
      add(const _StartedEvent());

  /// Загрузка бонусов
  Future<void> _onStarted(
    _StartedEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    await _hasAuthStatusUseCase.call().fold(
      (failure) => emit(_Error(message: failure.error)),
      (hasAuth) async {
        if (!hasAuth) return emit(const _Unauthorized());

        await _getBonusesUseCase.call(true).fold(
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

  /// Закрытие подписки на изменение статуса авторизации
  @override
  Future<void> close() async {
    await _authStatusSubscription?.cancel();
    return super.close();
  }
}
