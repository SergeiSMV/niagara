import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/stories/domain/repositories/stories_repository.dart';

@injectable
class MarkStorySeenUseCase extends BaseUseCase<bool, String> {
  const MarkStorySeenUseCase(this._repo);

  final IStoriesRepository _repo;

  @override
  Future<Either<Failure, bool>> call(String id) => _repo.markSeen(storyId: id);
}
