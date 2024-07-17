import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/new_products/domain/use_cases/get_new_products_use_case.dart';

part 'new_products_bloc.freezed.dart';
part 'new_products_event.dart';
part 'new_products_state.dart';

@injectable
class NewProductsBloc extends Bloc<NewProductsEvent, NewProductsState> {
  NewProductsBloc(this._useCase) : super(const _LoadingNewProducts()) {
    on<_LoadingNewProductsEvent>(_onLoad);
    on<_LoadingMoreNewProductsEvent>(_onLoadMore, transformer: debounce());

    add(const _LoadingNewProductsEvent());
  }

  final GetNewProductsUseCase _useCase;
  int _currentPage = 1;
  int _totalPages = 0;
  bool get hasMore => _totalPages > _currentPage;

  Future<void> _onLoad(
    _LoadingNewProductsEvent event,
    Emitter<NewProductsState> emit,
  ) async {
    // Если до этого были загружены какие-то другие товары, состояние "загрузка"
    // испускать не нужно.
    if (state is! _LoadedNewProducts) {
      emit(const _LoadingNewProducts());
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
      _LoadedNewProducts(
        products: result,
        totalItems: fetched.pagination.items,
        // Если загружена ещё не последняя страница, загрузка будет запущена в
        // любом случае.
        loadingMore: hasMore,
      ),
    );
  }

  Future<void> _onLoadMore(
    _LoadingMoreNewProductsEvent event,
    Emitter<NewProductsState> emit,
  ) async {
    if (state is _LoadingNewProducts || !hasMore) return;

    _currentPage++;
    add(const _LoadingNewProductsEvent());
  }
}
