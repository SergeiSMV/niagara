import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class INewProductsRemoteDataSource {
  Future<Either<Failure, ProductsDto>> getNewProducts({required int page});
}

@LazySingleton(as: INewProductsRemoteDataSource)
class NewProductsRemoteDataSource implements INewProductsRemoteDataSource {
  NewProductsRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, ProductsDto>> getNewProducts({
    required int page,
  }) =>
      _requestHandler.sendRequest<ProductsDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetNewProducts,
          queryParameters: {
            'page': page,
          },
        ),
        converter: (json) {
          final List<ProductDto> products = (json['data'] as List<dynamic>)
              .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList();
          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (products: products, pagination: pagination);
        },
        failure: NewProductsDataFailure.new,
      );
}
