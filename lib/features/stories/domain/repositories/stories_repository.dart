import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/stories/domain/model/story.dart';

abstract interface class IStoriesRepository {
  Future<Either<Failure, List<Story>>> getStories();
  Future<Either<Failure, bool>> markSeen({required String storyId});
}
