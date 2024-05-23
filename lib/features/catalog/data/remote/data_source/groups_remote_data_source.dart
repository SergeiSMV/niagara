import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/data/remote/dto/group_dto.dart';

abstract interface class IGroupsRemoteDataSource {
  Future<Either<Failure, List<GroupDto>>> getGroups({
    required String city,
  });
}

@LazySingleton(as: IGroupsRemoteDataSource)
class GroupsRemoteDataSource implements IGroupsRemoteDataSource {
  GroupsRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<GroupDto>>> getGroups({
    required String city,
  }) =>
      _requestHandler.sendRequest<List<GroupDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetGroups,
          queryParameters: {
            'city': city,
          },
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(GroupDto.fromJson)
            .toList(),
        failure: GroupsRemoteDataFailure.new,
      );
}
