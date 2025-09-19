import '../../../../core/common/domain/models/product.dart';
import '../../../../core/core.dart';
import '../repositories/catalog_repository.dart';

/// Usecase для получения товара по id
@injectable
class GetProductByIdUseCase extends BaseUseCase<Product?, String> {
  const GetProductByIdUseCase(this._catalogRepository);

  /// Репозиторий для работы с каталогом
  final ICatalogRepository _catalogRepository;

  /// Получает товар по id
  @override
  Future<Either<Failure, Product?>> call(String productId) async =>
      await _catalogRepository.getProductById(productId: productId);
}
