import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/features/catalog/data/remote/dto/filter_dto.dart';
import 'package:niagara_app/features/catalog/data/remote/dto/group_dto.dart';

abstract interface class ICatalogRemoteDataSource {
  Future<Either<Failure, List<GroupDto>>> getGroups();

  Future<Either<Failure, ProductsDto>> getCategory({
    required String groupId,
    required int page,
    required ProductsSortType sort,
    List<String>? filters,
  });

  Future<Either<Failure, List<ProductDto>>> getRecommend({
    required String productId,
  });

  Future<Either<Failure, List<FilterDto>>> getFilters({
    required String groupId,
  });

  Future<Either<Failure, ProductsDto>> getProductsBySearch({
    required String text,
    required int page,
    required ProductsSortType sort,
  });
}

@LazySingleton(as: ICatalogRemoteDataSource)
class CatalogRemoteDataSource implements ICatalogRemoteDataSource {
  CatalogRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

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

  @override
  Future<Either<Failure, ProductsDto>> getCategory({
    required String groupId,
    required int page,
    required ProductsSortType sort,
    List<String>? filters,
  }) =>
      _requestHandler.sendRequest<ProductsDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetCategory,
          queryParameters: {
            'product_group': groupId,
            'page': page,
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
}
