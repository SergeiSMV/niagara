import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/special_poducts/data/remote/data_source/special_products_remote_data_source.dart';
import 'package:niagara_app/features/special_poducts/domain/repositories/special_products_repository.dart';

@LazySingleton(as: ISpecialProductsRepository)
class SpecialProductsRepository extends BaseRepository
    implements ISpecialProductsRepository {
  SpecialProductsRepository(
    super._logger,
    super._networkInfo,
    this._source,
  );

  final ISpecialProductsRemoteDataSource _source;

  @override
  Failure get failure => const SpecialProductsRepositoryFailure();

  @override
  Future<Either<Failure, Products>> getSpecialProducts({required int page}) =>
      execute(() async {
        return _source.getSpecialProducts(page: page).fold(
              (failure) => throw failure,
              (dto) => (
                products: dto.products.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            );
      });
}
