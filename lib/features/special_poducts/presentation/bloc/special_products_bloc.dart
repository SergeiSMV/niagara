import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/special_poducts/domain/use_cases/special_products_use_case.dart';

part 'special_products_event.dart';
part 'special_products_bloc.freezed.dart';
part 'special_products_state.dart';

@injectable
class SpecialProductsBloc
    extends Bloc<SpecialProductsEvent, SpecialProductsState> {
  SpecialProductsBloc(this._useCase) : super(const _LoadingSpecialProducts()) {
    on<_LoadingSpecialProductsEvent>(_onLoad, transformer: debounce());
    on<_LoadingMoreSpecialProductsEvent>(_onLoadMore, transformer: debounce());

    add(const _LoadingSpecialProductsEvent());
  }

  final GetSpecialProductsUseCase _useCase;
  int _currentPage = 1;
  int _totalPages = 0;
  bool get hasMore => _totalPages > _currentPage;

  Future<void> _onLoad(
    _LoadingSpecialProductsEvent event,
    Emitter<SpecialProductsState> emit,
  ) async {
    // Если до этого были загружены какие-то другие товары, состояние "загрузка"
    // испускать не нужно.
    if (state is! _LoadedSpecialProducts) {
      emit(const _LoadingSpecialProducts());
    }

    final Products fetched = await _useCase
        .call(_currentPage)
        .fold((failure) => throw failure, (data) => data);

    _currentPage = fetched.pagination.current;
    _totalPages = fetched.pagination.total;

    final List<Product> current = state.maybeMap(
      loaded: (state) => state.products,
      orElse: () => const [],
    );

    final List<Product> result = [...current, ...fetched.products];

    return emit(
      _LoadedSpecialProducts(
        products: result,
        totalItems: fetched.pagination.items,
        // Если загружена ещё не последняя страница, загрузка будет запущена в
        // любом случае.
        loadingMore: hasMore,
      ),
    );
  }

  Future<void> _onLoadMore(
    _LoadingMoreSpecialProductsEvent event,
    Emitter<SpecialProductsState> emit,
  ) async {
    if (state is _LoadingSpecialProducts || !hasMore) return;

    _currentPage++;
    add(const _LoadingSpecialProductsEvent());
  }
}
