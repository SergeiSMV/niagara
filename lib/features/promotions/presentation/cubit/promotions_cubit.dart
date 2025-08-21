import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/core.dart';
import '../../domain/models/promotion.dart';
import '../../domain/use_cases/get_all_promotions_use_case.dart';
import '../../domain/use_cases/get_personal_promos_use_case.dart';

part 'promotions_state.dart';
part 'promotions_cubit.freezed.dart';

/// Кубит для загрузки промо на главной странице
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

  /// Кейс для загрузки всех промо
  final GetAllPromotionsUseCase _getAllPromotionsUseCase;

  /// Кейс для загрузки персональных промо
  final GetPersonalPromosUseCase _getPersonalPromosUseCase;

  /// Флаг определяющий загрузку персональных промо
  final bool _isPersonalLoad;

  /// Текущая страница
  int _current = 1;

  /// Общее количество страниц
  int _total = 1;

  /// Флаг для проверки, есть ли ещё страницы для загрузки
  bool get hasMore => _total > _current;

  /// Загрузка промо
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

  /// Загрузка последующих страниц промо
  Future<void> getMorePromotions() async {
    if (state is! _Loaded) return;

    if (hasMore) {
      _current++;
      getPromotions();
    }
  }
}
