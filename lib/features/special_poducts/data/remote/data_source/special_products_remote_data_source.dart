import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class ISpecialProductsRemoteDataSource {
  Future<Either<Failure, ProductsDto>> getSpecialProducts({required int page});
}

@LazySingleton(as: ISpecialProductsRemoteDataSource)
class SpecialProductsRemoteDataSource
    implements ISpecialProductsRemoteDataSource {
  SpecialProductsRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, ProductsDto>> getSpecialProducts({
    required int page,
  }) =>
      _requestHandler.sendRequest<ProductsDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetSpeialProducts,
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
        failure: SpecialProductsDataFailure.new,
      );
}
