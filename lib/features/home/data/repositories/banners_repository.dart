import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/home/data/data_sources/banners_remote_data_source.dart';
import 'package:niagara_app/features/home/data/mappers/banner_mapper.dart';
import 'package:niagara_app/features/home/domain/models/banner.dart';
import 'package:niagara_app/features/home/domain/repositories/banners_repository.dart';

@LazySingleton(as: IBannersRepository)
class BannersRepository extends BaseRepository implements IBannersRepository {
  const BannersRepository(
    super._logger,
    super._networkInfo,
    this._bannersRemoteDataSource,
  );

  final IBannersRemoteDataSource _bannersRemoteDataSource;

  @override
  Failure get failure => const BannersRepositoryFailure();

  @override
  Future<Either<Failure, List<Banner>>> getBanners() => execute(
        () => _bannersRemoteDataSource.getBanners().fold(
              (failure) => throw failure,
              (banners) => banners.map((e) => e.toModel()).toList(),
            ),
      );
}
