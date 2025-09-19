import '../../../../core/common/data/mappers/pagination_mapper.dart';
import '../../../../core/common/data/mappers/product_mapper.dart';
import '../../../../core/common/domain/models/product.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/enums/products_sort_type.dart';
import '../../domain/model/filter.dart';
import '../../domain/model/group.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../mappers/group_mapper_dto.dart';
import '../remote/data_source/catalog_remote_data_source.dart';

/// Репозиторий для работы с каталогом
@LazySingleton(as: ICatalogRepository)
class CatalogRepositories extends BaseRepository implements ICatalogRepository {
  CatalogRepositories(
    super._logger,
    super._networkInfo,
    this._groupsRDS,
  );

  /// Удаленный источник данных для работы с группами товаров
  final ICatalogRemoteDataSource _groupsRDS;

  /// Ошибка при работе с репозиторием
  @override
  Failure get failure => const GroupsRepositoryFailure();

  /// Получает список групп товаров
  @override
  Future<Either<Failure, List<Group>>> getGroups() => execute(
        () async => _groupsRDS.getGroups().fold(
              (failure) => throw failure,
              (dtos) => dtos.map((dto) => dto.toModel()).toList(),
            ),
      );

  /// Получает список товаров указанной группы
  @override
  Future<Either<Failure, Products>> getCategory({
    required Group group,
    required int page,
    required ProductsSortType sort,
    List<String>? filtersIDs,
    String? promotionId,
  }) =>
      execute(
        () async => _groupsRDS
            .getCategory(
              groupId: group.id,
              page: page,
              sort: sort,
              filters: filtersIDs,
              promotionId: promotionId,
            )
            .fold(
              (failure) => throw failure,
              (dto) => (
                products: dto.products.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            ),
      );

  /// Получает список рекомендованных товаров
  @override
  Future<Either<Failure, List<Product>>> getRecommends({
    required Product product,
  }) =>
      execute(
        () async => _groupsRDS
            .getRecommend(
              productId: product.id,
            )
            .fold(
              (failure) => throw failure,
              (dtos) => dtos.map((dto) => dto.toModel()).toList(),
            ),
      );

  /// Получает список фильтров для указанной группы
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

  /// Получает список товаров по поисковому запросу
  @override
  Future<Either<Failure, Products>> getProductsBySearch({
    required String text,
    required int page,
    required ProductsSortType sort,
  }) =>
      execute(
        () async => _groupsRDS
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
            ),
      );

  /// Получает товар по id
  @override
  Future<Either<Failure, Product>> getProductById({
    required String productId,
  }) =>
      execute(
        () async => _groupsRDS.getProductById(productId: productId).fold(
              (failure) => throw failure,
              (dto) => dto.toModel(),
            ),
      );
}
