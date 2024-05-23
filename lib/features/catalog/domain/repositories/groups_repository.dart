import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';

abstract interface class IGroupsRepository {
  Future<Either<Failure, List<Group>>> getGroups();
}
