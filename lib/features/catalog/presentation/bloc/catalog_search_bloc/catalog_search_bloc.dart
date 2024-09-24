import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/catalog/domain/use_cases/get_products_by_search_use_case.dart';

part 'catalog_search_bloc.freezed.dart';
part 'catalog_search_event.dart';
part 'catalog_search_state.dart';

typedef _Emit = Emitter<CatalogSearchState>;

@injectable
class CatalogSearchBloc extends Bloc<CatalogSearchEvent, CatalogSearchState> {
  CatalogSearchBloc(
    this._getProductsBySearchUseCase,
  ) : super(const _Initial()) {
    on<_Search>(_onSearchTextChanged, transformer: debounce());
    on<_LoadMore>(_onLoadMore);
    on<_Sort>(_sort, transformer: debounce());
  }

  final GetProductsBySearchUseCase _getProductsBySearchUseCase;

  ProductsSortType _sortType = ProductsSortType.none;
  ProductsSortType get sortType => _sortType;

  String _searchText = '';

  int _current = 1;
  int _total = 0;
  bool get hasMore => _total > _current;

  Future<void> _onSearchTextChanged(_Search event, _Emit emit) async {
    if (event.text.isEmpty && _searchText.isEmpty) return;

    if (event.isForceUpdate) {
      emit(const _Loading());
      _current = 0;
    }

    final products = state.maybeMap(
      loaded: (state) => state.products,
      orElse: () => const <Product>[],
    );

    _current++;
    _searchText = event.text;

    final data = await _getProductsBySearchUseCase(
      ProductsBySearchParams(
        text: _searchText,
        page: _current,
        sort: _sortType,
      ),
    ).fold(
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
      ),
    );
  }

  Future<void> _onLoadMore(_LoadMore event, _Emit emit) async {
    if (state is _Loading) return;
    if (hasMore) {
      add(
        _Search(
          text: _searchText,
          isForceUpdate: false,
        ),
      );
    }
  }

  void _sort(_Sort event, _Emit emit) {
    _sortType = event.sortType;
    add(
      _Search(
        text: _searchText,
        isForceUpdate: true,
      ),
    );
  }
}
