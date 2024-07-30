import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/about/data/remote/dto/policy_dto.dart';

abstract interface class IPoliciesRemoteDataSource {
  Future<Either<Failure, PolicyDto>> getPolicy({required String type});
}

@LazySingleton(as: IPoliciesRemoteDataSource)
class PoliciesRemoteDataSource implements IPoliciesRemoteDataSource {
  PoliciesRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, PolicyDto>> getPolicy({
    required String type,
  }) =>
      _requestHandler.sendRequest<PolicyDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetPolicies,
          queryParameters: {
            'type': type,
          },
        ),
        converter: (json) {
          final PolicyDto policy = PolicyDto.fromJson(
            json['data'] as Map<String, dynamic>,
          );

          return policy;
        },
        failure: PolicieslRemoteDataFailure.new,
      );
}
