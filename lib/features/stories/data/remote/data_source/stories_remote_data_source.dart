import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/stories/data/remote/dto/story_dto.dart';

abstract interface class IStoriesRemoteDataSource {
  Future<Either<Failure, List<StoryDto>>> getStories();
  Future<Either<Failure, bool>> markSeen({required String storyId});
}

@LazySingleton(as: IStoriesRemoteDataSource)
class StoriesRemoteDataSource implements IStoriesRemoteDataSource {
  StoriesRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<StoryDto>>> getStories() =>
      _requestHandler.sendRequest<List<StoryDto>, List<dynamic>>(
        request: (dio) => dio.get(ApiConst.kGetStories),
        converter: (json) {
          final List<StoryDto> stories = json
              .map((e) => StoryDto.fromJson(e as Map<String, dynamic>))
              .toList();

          return stories;
        },
        failure: StoriesDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> markSeen({required String storyId}) =>
      _requestHandler.sendRequest<bool, dynamic>(
        request: (dio) => dio.post(
          ApiConst.kMarkStorySeen,
          data: {
            'ID': storyId,
          },
        ),
        converter: (json) => true,
        failure: StoriesDataFailure.new,
      );
}
