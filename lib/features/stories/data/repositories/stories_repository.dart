import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/stories/data/mappers/story_mapper.dart';
import 'package:niagara_app/features/stories/data/remote/data_source/stories_remote_data_source.dart';
import 'package:niagara_app/features/stories/domain/model/story.dart';
import 'package:niagara_app/features/stories/domain/repositories/stories_repository.dart';

@LazySingleton(as: IStoriesRepository)
class StoriesRepository extends BaseRepository implements IStoriesRepository {
  StoriesRepository(
    super._logger,
    super._networkInfo,
    this._source,
  );

  final IStoriesRemoteDataSource _source;

  @override
  Failure get failure => const StoriesRepositoryFailure();

  @override
  Future<Either<Failure, List<Story>>> getStories() => execute(() async {
        return _source.getStories().fold(
              (failure) => throw failure,
              (dto) => dto.map((e) => e.toModel()).toList(),
            );
      });

  @override
  Future<Either<Failure, bool>> markSeen({required String storyId}) =>
      execute(() async {
        return _source.markSeen(storyId: storyId).fold(
              (failure) => throw failure,
              (dto) => dto,
            );
      });
}
