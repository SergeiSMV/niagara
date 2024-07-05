import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/promotions/data/mappers/promotions_mapper.dart';
import 'package:niagara_app/features/promotions/data/remote/data_source/promotions_remote_data_source.dart';
import 'package:niagara_app/features/promotions/domain/repositories/promotions_repository.dart';

@LazySingleton(as: IPromotionsRepository)
class PromotionsRepository extends BaseRepository
    implements IPromotionsRepository {
  PromotionsRepository(
    super._logger,
    this._promotionsRDS,
  );

  final IPromotionsRemoteDataSource _promotionsRDS;

  @override
  Failure get failure => const PromotionsRepositoryFailure();

  @override
  Future<Either<Failure, Promotions>> getPromotions({
    required int page,
    required bool isPersonal,
  }) =>
      execute(
        () async => await _promotionsRDS
            .getPromotions(
              page: page,
              isPersonal: isPersonal,
            )
            .fold(
              (failure) => throw failure,
              (dtos) => (
                promos: dtos.promos.map((dto) => dto.toModel()).toList(),
                pagination: dtos.pagination.toModel(),
              ),
            ),
      );
}
