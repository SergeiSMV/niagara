import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/new_products/domain/repositories/new_products_repository.dart';

@injectable
class GetNewProductsUseCase extends BaseUseCase<Products, int> {
  const GetNewProductsUseCase(this._repo);

  final INewProductsRepository _repo;

  @override
  Future<Either<Failure, Products>> call(int page) async =>
      _repo.getNewProducts(page: page);
}
