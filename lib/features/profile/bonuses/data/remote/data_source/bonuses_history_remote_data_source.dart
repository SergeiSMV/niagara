import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/bonus_history_dto.dart';

typedef BonusesHistoryDto = ({
  List<BonusHistoryDto> history,
  PaginationDto pagination
});

abstract interface class IBonusesHistoryRemoteDataSource {
  Future<Either<Failure, BonusesHistoryDto>> geBonusesHistory({
    required int page,
  });
}

@LazySingleton(as: IBonusesHistoryRemoteDataSource)
class BonusesHistoryRemoteDataSource
    implements IBonusesHistoryRemoteDataSource {
  BonusesHistoryRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, BonusesHistoryDto>> geBonusesHistory({
    required int page,
  }) =>
      _requestHandler.sendRequest<BonusesHistoryDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetBonusesHistory,
          queryParameters: {
            'page': page,
          },
        ),
        converter: (json) {
          final history = (json['data'] as List<dynamic>)
              .map((e) => BonusHistoryDto.fromJson(e as Map<String, dynamic>))
              .toList();

          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (history: history, pagination: pagination);
        },
        failure: BonusProgramRemoteDataFailure.new,
      );
}
