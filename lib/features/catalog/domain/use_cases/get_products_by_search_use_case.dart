// get_products_by_search_use_case
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class GetProductsBySearchUseCase
    extends BaseUseCase<List<Product>, ProductsBySearchParams> {
  const GetProductsBySearchUseCase(this._groupsRepository);

  final ICatalogRepository _groupsRepository;

  @override
  Future<Either<Failure, List<Product>>> call(
    ProductsBySearchParams params,
  ) async =>
      _groupsRepository.getProductsBySearch(text: params.text);
}

class ProductsBySearchParams extends Equatable {
  const ProductsBySearchParams(this.text);

  final String text;

  @override
  List<Object?> get props => [text];
}
