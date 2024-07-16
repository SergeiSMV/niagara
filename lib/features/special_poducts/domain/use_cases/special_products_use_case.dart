import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/special_poducts/domain/repositories/special_products_repository.dart';

@injectable
class GetSpecialProductsUseCase extends BaseUseCase<Products, int> {
  const GetSpecialProductsUseCase(this._repo);

  final ISpecialProductsRepository _repo;

  @override
  Future<Either<Failure, Products>> call(int page) async =>
      _repo.getSpecialProducts(page: page);
}
