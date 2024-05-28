import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class GetGroupsUseCase extends BaseUseCase<List<Group>, NoParams> {
  const GetGroupsUseCase(this._groupsRepository);

  final ICatalogRepository _groupsRepository;

  @override
  Future<Either<Failure, List<Group>>> call([NoParams? params]) async =>
      _groupsRepository.getGroups();
}
