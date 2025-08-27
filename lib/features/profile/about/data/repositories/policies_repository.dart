import '../../../../../core/core.dart';
import '../../../../../core/utils/enums/policy_type.dart';
import '../../domain/model/policy.dart';
import '../../domain/repositories/policies_repository.dart';
import '../local/data_source/policies_local_data_source.dart';
import '../local/entity/policy.dart';
import '../mappers/policy_mapper.dart';
import '../remote/data_sources/policies_remote_data_source.dart';

/// Репозиторий для работы с политикой конфиденциальности и маркетинговым
/// соглашением
@LazySingleton(as: IPoliciesRepository)
class PoliciesRepository extends BaseRepository implements IPoliciesRepository {
  PoliciesRepository(
    super._logger,
    super._networkInfo,
    this._rds,
    this._lds,
  );

  /// Удаленный источник данных для работы с политикой конфиденциальности
  final IPoliciesRemoteDataSource _rds;

  /// Локальный источник данных для работы с политикой конфиденциальности
  final IPoliciesLocalDataSource _lds;

  /// Возвращает ошибку, которая может возникнуть при работе с политикой
  @override
  Failure get failure => const PoliciesRepositoryFailure();

  /// Получение политики конфиденциальности или маркетингового соглашения
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

  /// Получение политики конфиденциальности или маркетингового соглашения
  /// из локального источника данных
  Future<Policy?> _getLocalPolicy(PolicyType type) =>
      _lds.getPolicy(type: type.name).fold(
            (failure) => null,
            (entity) => entity?.toModel(),
          );

  /// Получение политики конфиденциальности или маркетингового соглашения
  /// из удаленного источника данных
  Future<Policy?> _getRemotePolicy(PolicyType type) => execute(
        () => _rds.getPolicy(type: type.name).fold(
              (err) => null,
              (res) => res.toModel(),
            ),
      ).fold(
        (err) => null,
        (res) => res,
      );

  /// Кэширование политики конфиденциальности или маркетингового соглашения
  Future<void> _cachePolicy(PolicyEntity policy) async {
    await _lds.setPolicy(policy);
  }
}
