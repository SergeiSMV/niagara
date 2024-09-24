import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/domain/model/filter.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class GetFiltersUseCase extends BaseUseCase<List<Filter>, Group> {
  const GetFiltersUseCase(this._groupsRepository);

  final ICatalogRepository _groupsRepository;

  @override
  Future<Either<Failure, List<Filter>>> call(Group params) async =>
      _groupsRepository.getFilters(group: params);
}
