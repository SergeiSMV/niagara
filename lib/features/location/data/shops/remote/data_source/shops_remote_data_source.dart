import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/location/data/shops/remote/dto/shop_dto.dart';

abstract interface class IShopsRemoteDatasource {
  Future<Either<Failure, List<ShopDto>>> getShops({required String city});
}

@LazySingleton(as: IShopsRemoteDatasource)
class ShopsRemoteDatasource implements IShopsRemoteDatasource {
  ShopsRemoteDatasource({
    required RequestHandler requestHandler,
  }) : _requestHandler = requestHandler;

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<ShopDto>>> getShops({required String city}) =>
      _requestHandler.sendRequest<List<ShopDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetShops,
          queryParameters: {
            'city': city,
          },
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(ShopDto.fromJson)
            .toList(),
        failure: ShopsRemoteDataFailure.new,
      );
}
