import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonus_history.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_bonuses_history_use_case.dart';

part 'bonuses_history_cubit.freezed.dart';
part 'bonuses_history_state.dart';

@injectable
class BonusesHistoryCubit extends Cubit<BonusesHistoryState> {
  BonusesHistoryCubit(
    this._getBonusesHistoryUseCase,
  ) : super(const BonusesHistoryState.initial()) {
    /// Получаем историю бонусов при инициализации
    load();
  }

  final GetBonusesHistoryUseCase _getBonusesHistoryUseCase;

  int _current = 1;
  int _total = 0;

  bool get _hasMore => _total > _current;

  Future<void> load() async {
    if (state is _Loading) return;

    emit(const _Loading());

    await _getBonusesHistoryUseCase.call(_current).fold(
      (failure) => emit(const BonusesHistoryState.error()),
      (bonuses) {
        final data = bonuses.history;
        final pagination = bonuses.pagination;
        _current = pagination.current;
        _total = pagination.total;

        emit(
          _Loaded(
            history: [
              ...state.maybeWhen(
                loaded: (history, _) => history,
                orElse: () => [],
              ),
              ...data,
            ],
            hasMore: _hasMore,
          ),
        );
      },
    );
  }

  void loadMore() {
    if (state is _Loading) return;
    
    if (_hasMore) {
      _current++;
      load();
    }
  }
}
