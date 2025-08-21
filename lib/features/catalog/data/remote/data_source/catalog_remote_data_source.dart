import '../../../../../core/common/data/remote/dto/pagination_dto.dart';
import '../../../../../core/common/data/remote/dto/product_dto.dart';
import '../../../../../core/core.dart';
import '../../../../../core/utils/enums/products_sort_type.dart';
import '../dto/filter_dto.dart';
import '../dto/group_dto.dart';

/// Интерфейс для работы с удаленным источником данных для работы с каталогом
abstract interface class ICatalogRemoteDataSource {
  /// Получает список групп товаров
  Future<Either<Failure, List<GroupDto>>> getGroups();

  /// Получает список товаров указанной группы
  Future<Either<Failure, ProductsDto>> getCategory({
    required String groupId,
    required int page,
    required ProductsSortType sort,
    List<String>? filters,
    String? promotionId,
  });

  /// Получает список рекомендованных товаров
  Future<Either<Failure, List<ProductDto>>> getRecommend({
    required String productId,
  });

  /// Получает список фильтров для указанной группы
  Future<Either<Failure, List<FilterDto>>> getFilters({
    required String groupId,
  });

  /// Получает список товаров по поисковому запросу
  Future<Either<Failure, ProductsDto>> getProductsBySearch({
    required String text,
    required int page,
    required ProductsSortType sort,
  });

  /// Получает товар по id
  ///
  /// [productId] - идентификатор товара
  Future<Either<Failure, ProductDto>> getProductById({
    required String productId,
  });
}

/// Удаленный источник данных для работы с каталогом
@LazySingleton(as: ICatalogRemoteDataSource)
class CatalogRemoteDataSource implements ICatalogRemoteDataSource {
  CatalogRemoteDataSource(this._requestHandler);

  /// Обработчик запросов
  final RequestHandler _requestHandler;

  /// Получает список групп товаров
  @override
  Future<Either<Failure, List<GroupDto>>> getGroups() =>
      _requestHandler.sendRequest<List<GroupDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetGroups,
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(GroupDto.fromJson)
            .toList(),
        failure: GroupsRemoteDataFailure.new,
      );

  /// Получает список товаров указанной группы
  @override
  Future<Either<Failure, ProductsDto>> getCategory({
    required String groupId,
    required int page,
    required ProductsSortType sort,
    List<String>? filters,
    String? promotionId,
  }) =>
      _requestHandler.sendRequest<ProductsDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetCategory,
          queryParameters: {
            'product_group': groupId,
            'page': page,
            if (promotionId != null) 'offers': promotionId,
            if (sort != ProductsSortType.none) 'sort': sort.name,
            if (filters != null && filters.isNotEmpty)
              'filters': filters.join(','),
          },
        ),
        converter: (json) {
          final products = (json['data'] as List<dynamic>)
              .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList();

          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (products: products, pagination: pagination);
        },
        failure: GroupsRemoteDataFailure.new,
      );

  /// Получает список рекомендованных товаров
  @override
  Future<Either<Failure, List<ProductDto>>> getRecommend({
    required String productId,
  }) =>
      _requestHandler.sendRequest<List<ProductDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetRecommend,
          queryParameters: {
            'product': productId,
          },
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(ProductDto.fromJson)
            .toList(),
        failure: GroupsRemoteDataFailure.new,
      );

  /// Получает список фильтров для указанной группы
  @override
  Future<Either<Failure, List<FilterDto>>> getFilters({
    required String groupId,
  }) =>
      _requestHandler.sendRequest<List<FilterDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetFilters,
          queryParameters: {
            'product_group': groupId,
          },
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(FilterDto.fromJson)
            .toList(),
        failure: GroupsRemoteDataFailure.new,
      );

  /// Получает список товаров по поисковому запросу
  @override
  Future<Either<Failure, ProductsDto>> getProductsBySearch({
    required String text,
    required int page,
    required ProductsSortType sort,
  }) =>
      _requestHandler.sendRequest<ProductsDto, Map<String, dynamic>>(
        request: (Dio dio) => dio.get(
          ApiConst.kGetProductSearch,
          queryParameters: {
            'search_text': text,
            'page': page,
            if (sort != ProductsSortType.none) 'sort': sort.name,
          },
        ),
        converter: (json) {
          final products = (json['data'] as List<dynamic>)
              .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList();

          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (products: products, pagination: pagination);
        },
        failure: GroupsRemoteDataFailure.new,
      );

  /// Получает товар по id
  ///
  /// [productId] - идентификатор товара
  @override
  Future<Either<Failure, ProductDto>> getProductById({
    required String productId,
  }) =>
      _requestHandler.sendRequest<ProductDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetProductById,
          queryParameters: {
            'product_id': productId,
          },
        ),
        converter: ProductDto.fromJson,
        failure: GroupsRemoteDataFailure.new,
      );
}
