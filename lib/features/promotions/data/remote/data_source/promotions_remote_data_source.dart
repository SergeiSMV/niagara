import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/promotions/data/remote/dto/promotion_dto.dart';

typedef PromotionsDto = ({List<PromotionDto> promos, PaginationDto pagination});

abstract interface class IPromotionsRemoteDataSource {
  Future<Either<Failure, PromotionsDto>> getPromotions({
    required String city,
    required int page,
    required bool isPersonal,
  });
}

@LazySingleton(as: IPromotionsRemoteDataSource)
class PromotionsRemoteDataSource implements IPromotionsRemoteDataSource {
  PromotionsRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, PromotionsDto>> getPromotions({
    required String city,
    required int page,
    required bool isPersonal,
  }) async =>
      _requestHandler.sendRequest<PromotionsDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetPromos,
          queryParameters: {
            'city': city,
            'page': page,
            'personal': isPersonal, // TODO(Oleg): wait for new API
          },
        ),
        converter: (json) {
          final promos = (json['data'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
              .map(PromotionDto.fromJson)
              .toList();

          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (promos: promos, pagination: pagination);
        },
        failure: PromotionsRemoteDataFailure.new,
      );
}
