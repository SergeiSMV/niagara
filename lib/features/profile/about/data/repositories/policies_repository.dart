import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/new_products/domain/repositories/new_products_repository.dart';
import 'package:niagara_app/features/profile/about/data/remote/data_sources/policies_remote_data_source.dart';
import 'package:niagara_app/features/profile/about/data/remote/mappers/policy_mapper.dart';
import 'package:niagara_app/features/profile/about/domain/model/policy.dart';
import 'package:niagara_app/features/profile/about/domain/repositories/policies_repository.dart';

@LazySingleton(as: INewProductsRepository)
class PoliciesRepository extends BaseRepository implements IPoliciesRepository {
  PoliciesRepository(
    super._logger,
    super._networkInfo,
    this._source,
  );

  final IPoliciesRemoteDataSource _source;

  @override
  Failure get failure => const NewProductsRepositoryFailure();

  @override
  Future<Either<Failure, Policy>> getPolicy({required String type}) => execute(
        () async {
          return _source.getPolicy(type: type).fold(
                (failure) => throw failure,
                (dto) => dto.toModel(),
              );
        },
      );
}
