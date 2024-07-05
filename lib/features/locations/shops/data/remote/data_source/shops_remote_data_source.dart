import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/shops/data/remote/dto/shop_dto.dart';

abstract interface class IShopsRemoteDataSource {
  Future<Either<Failure, List<ShopDto>>> getShops();
}

@LazySingleton(as: IShopsRemoteDataSource)
class ShopsRemoteDatasource implements IShopsRemoteDataSource {
  ShopsRemoteDatasource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<ShopDto>>> getShops() =>
      _requestHandler.sendRequest<List<ShopDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetShops,
        
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(ShopDto.fromJson)
            .toList(),
        failure: ShopsRemoteDataFailure.new,
      );
}
