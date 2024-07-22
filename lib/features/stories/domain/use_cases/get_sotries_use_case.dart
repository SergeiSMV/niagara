import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/stories/domain/model/story.dart';
import 'package:niagara_app/features/stories/domain/repositories/stories_repository.dart';

@injectable
class GetStoriesUseCase extends BaseUseCase<List<Story>, NoParams> {
  const GetStoriesUseCase(this._repo);

  final IStoriesRepository _repo;

  @override
  Future<Either<Failure, List<Story>>> call([NoParams? _]) =>
      _repo.getStories();
}
