import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_description_dto.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_history_item_dto.dart';

abstract interface class IReferralRemoteDataSource {
  Future<Either<Failure, ReferralDescriptionDto>> getDescription();
  Future<Either<Failure, List<ReferralHistoryItemDto>>> getHistory();
}

@LazySingleton(as: IReferralRemoteDataSource)
class ReferralRemoteDataSource implements IReferralRemoteDataSource {
  ReferralRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, ReferralDescriptionDto>> getDescription() =>
      _requestHandler.sendRequest<ReferralDescriptionDto, Map<String, dynamic>>(
        request: (dio) => dio.get(ApiConst.kReferralInfo),
        converter: ReferralDescriptionDto.fromJson,
        failure: ReferralRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<ReferralHistoryItemDto>>> getHistory() =>
      _requestHandler.sendRequest<List<ReferralHistoryItemDto>,
          List<Map<String, dynamic>>>(
        request: (dio) => dio.get(ApiConst.kReferralHistory),
        converter: (json) => json.map(ReferralHistoryItemDto.fromJson).toList(),
        failure: ReferralRemoteDataFailure.new,
      );
}
