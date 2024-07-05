import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/features/catalog/data/mappers/group_mapper_dto.dart';
import 'package:niagara_app/features/catalog/data/remote/data_source/catalog_remote_data_source.dart';
import 'package:niagara_app/features/catalog/domain/model/filter.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:niagara_app/features/locations/cities/data/local/data_source/cities_local_data_source.dart';

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
    List<String>? filtersIDs,
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
              filters: filtersIDs,
            )
            .fold(
              (failure) => throw failure,
              (dto) => (
                products: dto.products.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            );
      });

  @override
  Future<Either<Failure, List<Product>>> getRecommends({
    required Product product,
  }) =>
      execute(() async {
        final currentCity = await _citiesLDS.getCity().fold(
              (failure) => throw failure,
              (city) => city,
            );

        return _groupsRDS
            .getRecommend(
              city: currentCity.locality,
              productId: product.id,
            )
            .fold(
              (failure) => throw failure,
              (dtos) => dtos.map((dto) => dto.toModel()).toList(),
            );
      });

  @override
  Future<Either<Failure, List<Filter>>> getFilters({
    required Group group,
  }) =>
      execute(() async {
        final filtersDtos = await _groupsRDS.getFilters(groupId: group.id).fold(
              (failure) => throw failure,
              (dtos) => dtos,
            );

        final Map<String, Filter> filtersMap = {};

        for (final dto in filtersDtos) {
          if (!filtersMap.containsKey(dto.propertyId)) {
            filtersMap[dto.propertyId] = Filter(
              id: dto.propertyId,
              name: dto.propertyName,
              properties: [
                FilterProperty(
                  id: dto.valueId,
                  name: dto.valueName,
                ),
              ],
            );
          } else {
            filtersMap[dto.propertyId]?.properties.add(
                  FilterProperty(
                    id: dto.valueId,
                    name: dto.valueName,
                  ),
                );
          }
        }

        return filtersMap.values.toList();
      });

  @override
  Future<Either<Failure, Products>> getProductsBySearch({
    required String text,
    required int page,
    required ProductsSortType sort,
  }) =>
      execute(() async {
        return _groupsRDS
            .getProductsBySearch(
              text: text,
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
