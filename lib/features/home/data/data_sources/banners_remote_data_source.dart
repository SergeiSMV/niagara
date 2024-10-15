import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/home/data/dto/banner_dto.dart';

abstract interface class IBannersRemoteDataSource {
  Future<Either<Failure, List<BannerDto>>> getBanners();
}

@LazySingleton(as: IBannersRemoteDataSource)
class BannersRemoteDataSource implements IBannersRemoteDataSource {
  BannersRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<BannerDto>>> getBanners() =>
      _requestHandler.sendRequest<List<BannerDto>, Map<String, dynamic>>(
        request: (dio) => dio.get(ApiConst.kGetBanners),
        converter: (json) => (json as List)
            .map((e) => BannerDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        failure: BannersRemoteDataFailure.new,
      );
}
