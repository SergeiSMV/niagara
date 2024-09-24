import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/new_products/data/remote/data_source/new_products_remote_data_source.dart';
import 'package:niagara_app/features/new_products/domain/repositories/new_products_repository.dart';

@LazySingleton(as: INewProductsRepository)
class NewProductsRepository extends BaseRepository
    implements INewProductsRepository {
  NewProductsRepository(
    super._logger,
    super._networkInfo,
    this._source,
  );

  final INewProductsRemoteDataSource _source;

  @override
  Failure get failure => const NewProductsRepositoryFailure();

  @override
  Future<Either<Failure, Products>> getNewProducts({required int page}) =>
      execute(() async {
        return _source.getNewProducts(page: page).fold(
              (failure) => throw failure,
              (dto) => (
                products: dto.products.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            );
      });
}
