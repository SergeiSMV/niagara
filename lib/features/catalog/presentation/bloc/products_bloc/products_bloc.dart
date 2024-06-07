import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/catalog/domain/model/filter.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/use_cases/get_filters_use_case.dart';
import 'package:niagara_app/features/catalog/domain/use_cases/get_products_use_case.dart';

part 'products_bloc.freezed.dart';
part 'products_event.dart';
part 'products_state.dart';

typedef _Emit = Emitter<ProductsState>;

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(
    this._getProductsUseCase,
    this._getFiltersUseCase, {
    @factoryParam required Group group,
  })  : _group = group,
        super(const _Loading()) {
    on<_LoadingEvent>(_onLoadProducts, transformer: debounce());
    on<_LoadMoreEvent>(_onLoadMoreProducts, transformer: debounce());
    on<_SetSortEvent>(_onSortChanged);

    add(const _LoadingEvent(isForceUpdate: true));
  }

  final Group _group;
  final GetProductsUseCase _getProductsUseCase;
  final GetFiltersUseCase _getFiltersUseCase;

  int _current = 1;
  int _total = 0;
  bool get hasMore => _total > _current;

  ProductsSortType _sort = ProductsSortType.none;
  ProductsSortType get sort => _sort;

  Future<void> _onLoadProducts(
    _LoadingEvent event,
    _Emit emit,
  ) async {
    if (event.isForceUpdate) {
      emit(const _Loading());
      _current = 0;
    }

    final products = state.maybeMap(
      loaded: (state) => state.products,
      orElse: () => const <Product>[],
    );

    _current++;

    final loadedProducts = await _getProductsUseCase
        .call(
      ProductsParams(
        page: _current,
        group: _group,
        sort: _sort,
      ),
    )
        .fold(
      (failure) => throw failure,
      (data) {
        _current = data.pagination.current;
        _total = data.pagination.total;
        return data.products;
      },
    );

    final filters = event.isForceUpdate
        ? await _getFiltersUseCase.call(_group).fold(
              (failure) => throw failure,
              (data) => data,
            )
        : state.maybeMap(
            loaded: (state) => state.filters,
            orElse: () => const <Filter>[],
          );

    emit(
      _Loaded(
        products: event.isForceUpdate
            ? loadedProducts
            : [...products, ...loadedProducts],
        filters: filters,
      ),
    );
    return;
  }

  Future<void> _onLoadMoreProducts(
    _LoadMoreEvent event,
    _Emit emit,
  ) async {
    if (state is _Loading) return;
    if (hasMore) add(const _LoadingEvent(isForceUpdate: false));
  }

  Future<void> _onSortChanged(
    _SetSortEvent event,
    _Emit emit,
  ) async {
    _sort = event.sort;
    add(const _LoadingEvent(isForceUpdate: true));
  }
}
