import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/cities/data/local/data_source/cities_local_data_source.dart';
import 'package:niagara_app/features/promotions/data/mappers/promotions_mapper.dart';
import 'package:niagara_app/features/promotions/data/remote/data_source/promotions_remote_data_source.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';
import 'package:niagara_app/features/promotions/domain/repositories/promotions_repository.dart';

@LazySingleton(as: IPromotionsRepository)
class PromotionsRepository extends BaseRepository
    implements IPromotionsRepository {
  PromotionsRepository(
    super._logger,
    this._promotionsRDS,
    this._citiesLDS,
  );

  final IPromotionsRemoteDataSource _promotionsRDS;
  final ICitiesLocalDataSource _citiesLDS;

  @override
  Failure get failure => const PromotionsRepositoryFailure();

  @override
  Future<Either<Failure, List<Promotion>>> getPromotions() => execute(() async {
        final currentCity = await _citiesLDS.getCity().fold(
              (failure) => throw failure,
              (city) => city,
            );

        final promos =
            await _promotionsRDS.getPromotions(city: currentCity.locality).fold(
                  (failure) => throw failure,
                  (dtos) => dtos.map((dto) => dto.toModel()).toList(),
                );

        return promos;
      });
}
