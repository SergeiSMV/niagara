import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';
import 'package:niagara_app/features/promotions/domain/use_cases/get_all_promotions_use_case.dart';
import 'package:niagara_app/features/promotions/domain/use_cases/get_personal_promos_use_case.dart';

part 'promotions_state.dart';
part 'promotions_cubit.freezed.dart';

@injectable
class PromotionsCubit extends Cubit<PromotionsState> {
  PromotionsCubit(
    this._getAllPromotionsUseCase,
    this._getPersonalPromosUseCase, {
    @factoryParam bool isPersonalLoad = false,
  })  : _isPersonalLoad = isPersonalLoad,
        super(const _Loading()) {
    /// Получаем данные при первом запуске
    getPromotions();
  }

  final GetAllPromotionsUseCase _getAllPromotionsUseCase;
  final GetPersonalPromosUseCase _getPersonalPromosUseCase;

  final bool _isPersonalLoad;

  int _current = 1;
  int _total = 1;

  bool get hasMore => _total > _current;

  Future<void> getPromotions() async {
    emit(const _Loading());
    await (_isPersonalLoad
            ? _getPersonalPromosUseCase
            : _getAllPromotionsUseCase)
        .call(_current)
        .fold((_) => emit(const _Error()), (data) {
      _current = data.pagination.current;
      _total = data.pagination.total;

      return emit(
        _Loaded(
          promotions: [
            ...state.maybeWhen(
              orElse: List.empty,
              loaded: (promotions) => promotions,
            ),
            ...data.promos,
          ],
        ),
      );
    });
  }

  Future<void> getMorePromotions() async {
    if (state is! _Loaded) return;

    if (hasMore) {
      _current++;
      getPromotions();
    }
  }
}
