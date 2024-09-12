import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_bonuses_use_case.dart';

part 'water_balance_state.dart';
part 'water_balance_cubit.freezed.dart';

@lazySingleton
class WaterBalanceCubit extends Cubit<WaterBalanceState> {
  WaterBalanceCubit(
    this._getBonusesUseCase,
    this._hasAuthStatusUseCase,
  ) : super(const WaterBalanceState.loading()) {
    getBottles();
  }

  /// Кейс получения баланса воды через [Bonuses.bottles].
  final GetBonusesUseCase _getBonusesUseCase;

  /// Кейс проверки авторизации.
  final HasAuthStatusUseCase _hasAuthStatusUseCase;

  /// Проверяет, пуст ли баланс воды.
  ///
  /// Возвращает `false`, если баланс загружен и не пуст и `true` во всех
  /// остальных случаях.
  bool get isEmpty => state.maybeWhen(
        loaded: (balance) => balance.bottles.isEmpty,
        orElse: () => true,
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
  void _getBottles() => _getBonusesUseCase().fold(
        (failure) => emit(const WaterBalanceState.error()),
        (bonuses) {
          if (bonuses.bottles.bottles.isEmpty) {
            emit(const WaterBalanceState.empty());
          } else {
            emit(WaterBalanceState.loaded(balance: bonuses.bottles));
          }
        },
      );
}
