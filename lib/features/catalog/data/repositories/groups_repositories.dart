import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/data/mappers/group_mapper_dto.dart';
import 'package:niagara_app/features/catalog/data/remote/data_source/groups_remote_data_source.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/repositories/groups_repository.dart';
import 'package:niagara_app/features/locations/cities/data/local/data_source/cities_local_data_source.dart';

@LazySingleton(as: IGroupsRepository)
class GroupsRepositories extends BaseRepository implements IGroupsRepository {
  GroupsRepositories(
    super._logger,
    this._groupsRDS,
    this._citiesLDS,
  );

  final IGroupsRemoteDataSource _groupsRDS;
  final ICitiesLocalDataSource _citiesLDS;

  @override
  Failure get failure => const GroupsRepositoryFailure();

  @override
  Future<Either<Failure, List<Group>>> getGroups() => execute(() async {
        final currentCity = await _citiesLDS.getCity().fold(
              (failure) => throw failure,
              (city) => city,
            );
            
        return _groupsRDS
            .getGroups(
              city: currentCity.locality,
            )
            .fold(
              (failure) => throw failure,
              (dtos) => dtos.map((dto) => dto.toModel()).toList(),
            );
      });
}
