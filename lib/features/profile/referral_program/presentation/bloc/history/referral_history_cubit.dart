import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_history.dart';
import 'package:niagara_app/features/profile/referral_program/domain/use_cases/get_referral_history_use_case.dart';

part 'referral_history_state.dart';
part 'referral_history_cubit.freezed.dart';

@injectable
class ReferralHistoryCubit extends Cubit<ReferralHistoryState> {
  ReferralHistoryCubit(this._getReferralHistoryUseCase)
      : super(const ReferralHistoryState.initial()) {
    load();
  }

  final GetReferralHistoryUseCase _getReferralHistoryUseCase;

  int _current = 1;
  int _total = 0;

  bool get _hasMore => _total > _current;

  Future<void> load() async {
    if (state is _Loading) return;
    emit(const ReferralHistoryState.loading());

    final result = await _getReferralHistoryUseCase(_current);
    result.fold(
      (failure) => emit(const ReferralHistoryState.error()),
      (data) {
        _current = data.pagination.current;
        _total = data.pagination.total;

        emit(
          ReferralHistoryState.loaded(
            history: [
              ...state.maybeWhen(
                loaded: (history, _) => history,
                orElse: () => [],
              ),
              ...data.history,
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
