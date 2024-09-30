import 'dart:math';

import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_code_data_dto.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_description_dto.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_history_item_dto.dart';

abstract interface class IReferralRemoteDataSource {
  Future<Either<Failure, ReferralDescriptionDto>> getDescription();
  Future<Either<Failure, ReferralHistoryDto>> getHistory({required int page});
  Future<Either<Failure, ReferralCodeDataDto>> createCode();
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
  Future<Either<Failure, ReferralHistoryDto>> getHistory({
    required int page,
  }) =>
      _requestHandler.sendRequest<ReferralHistoryDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kReferralHistory,
          queryParameters: {
            'page': page,
          },
        ),
        converter: (json) {
          final history = (json['data'] as List<dynamic>)
              .map(
                (e) =>
                    ReferralHistoryItemDto.fromJson(e as Map<String, dynamic>),
              )
              .toList();
          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (history: history, pagination: pagination);
        },
        failure: ReferralRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, ReferralCodeDataDto>> createCode() =>
      _requestHandler.sendRequest<ReferralCodeDataDto, Map<String, dynamic>>(
        request: (dio) => dio.post(ApiConst.kReferralCode),
        converter: ReferralCodeDataDto.fromJson,
        failure: ReferralRemoteDataFailure.new,
      );
}
