import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/promotions/data/remote/dto/promotion_dto.dart';

abstract interface class IPromotionsRemoteDataSource {
  Future<Either<Failure, List<PromotionDto>>> getPromotions({
    required String city,
  });
}

@LazySingleton(as: IPromotionsRemoteDataSource)
class PromotionsRemoteDataSource implements IPromotionsRemoteDataSource {
  PromotionsRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<PromotionDto>>> getPromotions({
    required String city,
  }) async =>
      _requestHandler.sendRequest<List<PromotionDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetPromos,
          queryParameters: {'city': city},
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(PromotionDto.fromJson)
            .toList(),
        failure: PromotionsRemoteDataFailure.new,
      );
}
