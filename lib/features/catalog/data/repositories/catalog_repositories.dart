import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/features/catalog/data/mappers/group_mapper_dto.dart';
import 'package:niagara_app/features/catalog/data/remote/data_source/catalog_remote_data_source.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:niagara_app/features/locations/cities/data/local/data_source/cities_local_data_source.dart';

typedef ProductsDto = ({List<ProductDto> products, PaginationDto pagination});

@LazySingleton(as: ICatalogRepository)
class CatalogRepositories extends BaseRepository implements ICatalogRepository {
  CatalogRepositories(
    super._logger,
    this._groupsRDS,
    this._citiesLDS,
  );

  final ICatalogRemoteDataSource _groupsRDS;
  final ICitiesLocalDataSource _citiesLDS;

  @override
  Failure get failure => const GroupsRepositoryFailure();

  @override
  Future<Either<Failure, List<Group>>> getGroups() => execute(() async {
        final currentCity = await _citiesLDS.getCity().fold(
              (failure) => throw failure,
              (city) => city,
            );

        return _groupsRDS
            .getGroups(
              city: currentCity.locality,
            )
            .fold(
              (failure) => throw failure,
              (dtos) => dtos.map((dto) => dto.toModel()).toList(),
            );
      });

  @override
  Future<Either<Failure, Products>> getCategory({
    required Group group,
    required int page,
    required ProductsSortType sort,
  }) =>
      execute(() async {
        final currentCity = await _citiesLDS.getCity().fold(
              (failure) => throw failure,
              (city) => city,
            );

        return _groupsRDS
            .getCategory(
              city: currentCity.locality,
              groupId: group.id,
              page: page,
              sort: sort,
            )
            .fold(
              (failure) => throw failure,
              (dto) => (
                products: dto.products.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            );
      });
}
