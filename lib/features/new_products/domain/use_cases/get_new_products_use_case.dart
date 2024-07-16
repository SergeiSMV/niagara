import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/new_products/domain/repositories/new_products_repository.dart';

@injectable
class GetNewProductsUseCase extends BaseUseCase<Products, NewProductsParams> {
  const GetNewProductsUseCase(this._groupsRepository);

  final INewProductsRepository _groupsRepository;

  @override
  Future<Either<Failure, Products>> call(NewProductsParams params) async =>
      _groupsRepository.getNewProducts(
        page: params.page,
      );
}

class NewProductsParams extends Equatable {
  const NewProductsParams({required this.page});

  final int page;

  @override
  List<Object?> get props => [page];
}
