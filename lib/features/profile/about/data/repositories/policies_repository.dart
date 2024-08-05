import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/policy_type.dart';
import 'package:niagara_app/features/profile/about/data/local/data_source/policies_local_data_source.dart';
import 'package:niagara_app/features/profile/about/data/local/entity/policy.dart';
import 'package:niagara_app/features/profile/about/data/mappers/policy_mapper.dart';
import 'package:niagara_app/features/profile/about/data/remote/data_sources/policies_remote_data_source.dart';
import 'package:niagara_app/features/profile/about/domain/model/policy.dart';
import 'package:niagara_app/features/profile/about/domain/repositories/policies_repository.dart';

@LazySingleton(as: IPoliciesRepository)
class PoliciesRepository extends BaseRepository implements IPoliciesRepository {
  PoliciesRepository(
    super._logger,
    super._networkInfo,
    this._rds,
    this._lds,
  );

  final IPoliciesRemoteDataSource _rds;
  final IPoliciesLocalDataSource _lds;

  @override
  Failure get failure => const PoliciesRepositoryFailure();

  @override
  Future<Either<Failure, Policy>> getPolicy({required PolicyType type}) async {
    final Policy? local = await _getLocalPolicy(type);
    final Policy? remote = await _getRemotePolicy(type);

    if (remote != null) {
      _cachePolicy(remote.toEntity(type));
      return Right(remote);
    } else {
      return local != null ? Right(local) : Left(failure);
    }
  }

  Future<Policy?> _getLocalPolicy(PolicyType type) =>
      _lds.getPolicy(type: type.name).fold(
            (failure) => null,
            (entity) => entity?.toModel(),
          );

  Future<Policy?> _getRemotePolicy(PolicyType type) => execute(
        () => _rds.getPolicy(type: type.name).fold(
              (err) => null,
              (res) => res.toModel(),
            ),
      ).fold(
        (err) => null,
        (res) => res,
      );

  Future<void> _cachePolicy(PolicyEntity policy) async {
    await _lds.setPolicy(policy);
  }
}
