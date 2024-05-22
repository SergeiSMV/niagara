import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';
import 'package:niagara_app/features/promotions/domain/use_cases/get_promotions_use_case.dart';

part 'promotions_state.dart';
part 'promotions_cubit.freezed.dart';

@injectable
class PromotionsCubit extends Cubit<PromotionsState> {
  PromotionsCubit(this._getPromotionsUseCase) : super(const _Initial()) {
    /// Получаем данные при первом запуске
    getPromotions();
  }

  final GetPromotionsUseCase _getPromotionsUseCase;

  Future<void> getPromotions() async {
    emit(const _Loading());
    await _getPromotionsUseCase.call().fold(
          (_) => emit(const _Error()),
          (promotions) => emit(_Loaded(promotions)),
        );
  }
}
