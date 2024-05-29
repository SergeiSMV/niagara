import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/domain/use_cases/get_recommends_use_case.dart';

part 'recommends_cubit.freezed.dart';
part 'recommends_state.dart';

@injectable
class RecommendsCubit extends Cubit<RecommendsState> {
  RecommendsCubit(
    this._getRecommendsUseCase, {
    @factoryParam required Product product,
  })  : _product = product,
        super(const RecommendsState.loading()) {
    getRecommends();
  }

  final GetRecommendsUseCase _getRecommendsUseCase;

  final Product _product;

  Future<void> getRecommends() async {
    final result = await _getRecommendsUseCase.call(_product);
    result.fold(
      (_) => emit(const RecommendsState.error()),
      (products) => emit(RecommendsState.loaded(products: products)),
    );
  }
}
