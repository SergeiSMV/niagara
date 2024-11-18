import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/catalog/domain/model/filter.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/use_cases/get_products_use_case.dart';

part 'products_bloc.freezed.dart';
part 'products_event.dart';
part 'products_state.dart';

typedef _Emit = Emitter<ProductsState>;

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(
    this._getProductsUseCase, {
    @factoryParam required Group group,
  })  : _group = group,
        super(const _Loading()) {
    on<_LoadingEvent>(_onLoadProducts, transformer: debounce());
    on<_LoadMoreEvent>(_onLoadMoreProducts, transformer: debounce());
    on<_SetSortEvent>(_onSortChanged);

    add(const _LoadingEvent(isForceUpdate: true, filters: []));
  }

  Group _group;
  Group get group => _group;

  // TODO: сделать эвентом
  void onGroupUpdated(Group group) {
    _group = group;
    add(const _LoadingEvent(isForceUpdate: true, filters: []));
  }

  final GetProductsUseCase _getProductsUseCase;

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

    final data = await _getProductsUseCase
        .call(
          ProductsParams(
            page: _current,
            group: _group,
            sort: _sort,
            filters: event.filters,
          ),
        )
        .fold(
          (failure) => throw failure,
          (data) => data,
        );

    _current = data.pagination.current;
    _total = data.pagination.total;

    emit(
      _Loaded(
        products: event.isForceUpdate
            ? data.products
            : [...products, ...data.products],
        totalItems: data.pagination.items,
      ),
    );
    return;
  }

  Future<void> _onLoadMoreProducts(
    _LoadMoreEvent event,
    _Emit emit,
  ) async {
    if (state is _Loading) return;
    if (hasMore) {
      add(
        _LoadingEvent(
          isForceUpdate: false,
          filters: event.filters,
        ),
      );
    }
  }

  Future<void> _onSortChanged(
    _SetSortEvent event,
    _Emit emit,
  ) async {
    _sort = event.sort;
    add(
      _LoadingEvent(
        isForceUpdate: true,
        filters: event.filters,
      ),
    );
  }
}
