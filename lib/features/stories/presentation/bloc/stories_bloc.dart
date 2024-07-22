import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/stories/domain/model/story.dart';
import 'package:niagara_app/features/stories/domain/use_cases/get_sotries_use_case.dart';
import 'package:niagara_app/features/stories/domain/use_cases/mark_story_seen_use_case.dart';

part 'stories_event.dart';
part 'stories_state.dart';
part 'stories_bloc.freezed.dart';

@injectable
class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  StoriesBloc(this._getCase, this._markCase) : super(const _LoadingStories()) {
    on<_LoadStoriesEvent>(_onLoad);
    on<_MarkSeenStoriesEvent>(_onMark);

    add(const _LoadStoriesEvent());
  }

  final GetStoriesUseCase _getCase;
  final MarkStorySeenUseCase _markCase;
  final Set<String> seenStories = {};

  Future<void> _onLoad(
    _LoadStoriesEvent event,
    Emitter<StoriesState> emit,
  ) async {
    final List<Story> fetched = await _getCase
        .call(NoParams())
        .fold((failure) => throw failure, (data) => data);

    return emit(_LoadedStories(stories: fetched));
  }

  Future<void> _onMark(
    _MarkSeenStoriesEvent event,
    Emitter<StoriesState> emit,
  ) async {
    if (state is! _LoadedStories) return;

    final String storyId = event.id;
    final List<Story> stories = (state as _LoadedStories).stories;

    // Если история уже открыта, то не нужно ее помечать
    if (stories.any((s) => s.id == storyId && s.open)) return;

    final bool result = await _markCase
        .call(event.id)
        .fold((failure) => throw failure, (data) => data);

    if (result) {
      // Добавить в список историй, которые были помечены прочитанными.
      seenStories.add(storyId);

      final List<Story> newList = List.from(stories);

      // Пройтись по всем прочитанным историям нужно, чтобы не возникало
      // конкурентных гонок из-за асинхронных запросов.
      for (final String id in seenStories) {
        final int index = stories.indexWhere((s) => s.id == id);
        if (index != -1) {
          newList[index] = stories[index].copyWithOpen(true);
        }
      }

      return emit(_LoadedStories(stories: newList));
    }
  }
}
