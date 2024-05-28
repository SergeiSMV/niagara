import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class GetProductsUseCase extends BaseUseCase<Products, ProductsParams> {
  const GetProductsUseCase(this._groupsRepository);

  final ICatalogRepository _groupsRepository;

  @override
  Future<Either<Failure, Products>> call(ProductsParams params) async =>
      _groupsRepository.getCategory(
        group: params.group,
        page: params.page,
        sort: params.sort,
      );
}

class ProductsParams extends Equatable {
  const ProductsParams({
    required this.group,
    required this.page,
    required this.sort,
  });

  final Group group;
  final int page;
  final ProductsSortType sort;

  @override
  List<Object?> get props => [
        group,
        page,
        sort,
      ];
}
