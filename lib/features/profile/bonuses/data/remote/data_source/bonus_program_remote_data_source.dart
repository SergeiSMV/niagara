import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/about_bonus_program_dto.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/faq_bonuses_dto.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/status_description_dto.dart';

abstract interface class IBonusProgramRemoteDataSource {
  Future<Either<Failure, AboutBonusProgramDto>> getAboutBonusProgram();

  Future<Either<Failure, List<FaqBonusesDto>>> getFaqBonusProgram();

  Future<Either<Failure, List<StatusDescriptionDto>>> getStatusesDescription();

  Future<Either<Failure, StatusDescriptionDto>> getStatusDescription({
    required String status,
  });
}

@LazySingleton(as: IBonusProgramRemoteDataSource)
class BonusProgramRemoteDataSource implements IBonusProgramRemoteDataSource {
  BonusProgramRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, AboutBonusProgramDto>> getAboutBonusProgram() =>
      _requestHandler.sendRequest<AboutBonusProgramDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetBonusProgram,
        ),
        converter: AboutBonusProgramDto.fromJson,
        failure: BonusProgramRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<FaqBonusesDto>>> getFaqBonusProgram() =>
      _requestHandler.sendRequest<List<FaqBonusesDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetFaqBonusProgram,
        ),
        converter: (json) => json
            .map((e) => FaqBonusesDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        failure: BonusProgramRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<StatusDescriptionDto>>>
      getStatusesDescription() => _requestHandler
              .sendRequest<List<StatusDescriptionDto>, List<dynamic>>(
            request: (dio) => dio.get(
              ApiConst.kGetStatusesDescriptions,
            ),
            converter: (json) => json
                .map(
                  (e) =>
                      StatusDescriptionDto.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
            failure: BonusProgramRemoteDataFailure.new,
          );

  @override
  Future<Either<Failure, StatusDescriptionDto>> getStatusDescription({
    required String status,
  }) =>
      _requestHandler.sendRequest<StatusDescriptionDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetStatusDescription,
          queryParameters: {
            'status': status,
          },
        ),
        converter: StatusDescriptionDto.fromJson,
        failure: BonusProgramRemoteDataFailure.new,
      );
}
