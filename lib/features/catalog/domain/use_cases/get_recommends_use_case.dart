import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class GetRecommendsUseCase extends BaseUseCase<List<Product>, Product> {
  const GetRecommendsUseCase(this._groupsRepository);

  final ICatalogRepository _groupsRepository;

  @override
  Future<Either<Failure, List<Product>>> call(Product params) async =>
      _groupsRepository.getRecommends(product: params);
}
