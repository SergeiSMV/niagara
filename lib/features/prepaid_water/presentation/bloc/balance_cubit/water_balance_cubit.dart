import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/core.dart';
import '../../../../../core/utils/enums/auth_status.dart';
import '../../../../authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import '../../../../profile/bonuses/domain/models/bonuses.dart';
import '../../../../profile/bonuses/domain/use_cases/get_bonuses_use_case.dart';

part 'water_balance_state.dart';
part 'water_balance_cubit.freezed.dart';

/// [Cubit] для получения баланса предоплатной воды.
@lazySingleton
class WaterBalanceCubit extends Cubit<WaterBalanceState> {
  WaterBalanceCubit(
    this._getBonusesUseCase,
    this._hasAuthStatusUseCase,
    this._authStatusStream,
  ) : super(const WaterBalanceState.loading()) {
    _authStatusSubscription = _authStatusStream.listen((_) => getBottles());
    // Загружаем баланс бутылей при инициализации.
    getBottles();
  }

  /// Кейс получения баланса воды через [Bonuses.bottles].
  final GetBonusesUseCase _getBonusesUseCase;

  /// Кейс проверки авторизации.
  final HasAuthStatusUseCase _hasAuthStatusUseCase;

  /// [Stream] статуса авторизации.
  final Stream<AuthenticatedStatus> _authStatusStream;

  /// Подписка на изменение статуса авторизации.
  StreamSubscription? _authStatusSubscription;

  /// Идентификатор группы "Акции" в каталоге для предоплатной воды.
  String? bottlesGroupId;

  /// Определяет, возможно ли отрисовать количество бутылей на балансе.
  ///
  /// Возвращает `false` в случае ошибки или при отсутствии авторизации.
  bool get canDisplayAmount => state.maybeWhen(
        error: () => false,
        unauthorized: () => false,
        orElse: () => true,
      );

  /// Возвращает общее количество бутылей на балансе.
  int get count => state.maybeWhen(
        loaded: (balance) => balance.count,
        orElse: () => 0,
      );

  /// Проверяет авторизацию и запрашивает состояние баланса воды.
  Future<void> getBottles() async {
    emit(const WaterBalanceState.loading());

    _hasAuthStatusUseCase().fold(
      (failure) => emit(const WaterBalanceState.error()),
      (hasAuth) => hasAuth
          ? _getBottles()
          : emit(const WaterBalanceState.unauthorized()),
    );
  }

  /// Получает баланс воды.
  void _getBottles() => _getBonusesUseCase(true).fold(
        (failure) => emit(const WaterBalanceState.error()),
        (bonuses) {
          bottlesGroupId = bonuses.bottlesGroupId;

          if (bonuses.bottles.bottles.isEmpty) {
            emit(const WaterBalanceState.empty());
          } else {
            emit(WaterBalanceState.loaded(balance: bonuses.bottles));
          }
        },
      );

  @override
  Future<void> close() {
    _authStatusSubscription?.cancel();
    return super.close();
  }
}
