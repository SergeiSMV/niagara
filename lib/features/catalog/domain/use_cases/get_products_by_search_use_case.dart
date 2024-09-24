import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class GetProductsBySearchUseCase
    extends BaseUseCase<Products, ProductsBySearchParams> {
  const GetProductsBySearchUseCase(this._groupsRepository);

  final ICatalogRepository _groupsRepository;

  @override
  Future<Either<Failure, Products>> call(
    ProductsBySearchParams params,
  ) async =>
      _groupsRepository.getProductsBySearch(
        text: params.text,
        page: params.page,
        sort: params.sort,
      );
}

class ProductsBySearchParams extends Equatable {
  const ProductsBySearchParams({
    required this.text,
    required this.page,
    required this.sort,
  });

  final String text;
  final int page;
  final ProductsSortType sort;

  @override
  List<Object?> get props => [text, page, sort];
}
