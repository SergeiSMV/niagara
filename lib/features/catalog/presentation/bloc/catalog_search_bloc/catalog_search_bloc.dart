import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/features/catalog/domain/use_cases/get_products_by_search_use_case.dart';

part 'catalog_search_event.dart';
part 'catalog_search_state.dart';
part 'catalog_search_bloc.freezed.dart';

typedef _Emit = Emitter<CatalogSearchState>;

@injectable
class CatalogSearchBloc extends Bloc<CatalogSearchEvent, CatalogSearchState> {
  CatalogSearchBloc(
    this._getProductsBySearchUseCase,
  ) : super(const _Initial()) {
    on<_Search>(_onSearchTextChanged, transformer: sequential());
    on<_Sort>(_sort);
  }

  final GetProductsBySearchUseCase _getProductsBySearchUseCase;

  final List<Product> _products = [];
  final List<Product> _sortProducts = [];
  List<Product> get products => _sortProducts;

  ProductsSortType _sortType = ProductsSortType.none;
  ProductsSortType get sortType => _sortType;

  String _searchText = '';

  Future<void> _onSearchTextChanged(_Search event, _Emit emit) async {
    if (event.text.isEmpty && _searchText.isEmpty) return;

    _products.clear();
    _sortType = ProductsSortType.none;
    _searchText = event.text;
    emit(const _Loading());
    await _getProductsBySearchUseCase(ProductsBySearchParams(_searchText)).fold(
      (failure) => emit(const _Error()),
      (data) {
        _products.addAll(data);
        emit(_Loaded(products: _products));
      },
    );
  }

  void _sort(_Sort event, _Emit emit) {
    if (event.sortType == _sortType) return;

    _sortType = event.sortType;
    _sortProducts.clear();
    switch (event.sortType) {
      case ProductsSortType.none:
        _sortProducts.addAll(_products);
      case ProductsSortType.min:
        _sortProducts.addAll(
          _products.toList()..sort((a, b) => a.price.compareTo(b.price)),
        );
      case ProductsSortType.max:
        _sortProducts.addAll(
          _products.toList()..sort((a, b) => b.price.compareTo(a.price)),
        );
    }
    emit(_Loaded(products: _sortProducts));
  }
}
