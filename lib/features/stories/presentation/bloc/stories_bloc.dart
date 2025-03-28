import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/core.dart';
import '../../domain/model/story.dart';
import '../../domain/use_cases/get_sotries_use_case.dart';
import '../../domain/use_cases/mark_story_seen_use_case.dart';

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
    try {
      final result = await _getCase.call(NoParams());

      result.fold(
        (failure) => emit(const StoriesState.error()),
        (stories) => emit(StoriesState.loaded(stories: stories)),
      );
    } on Failure {
      emit(const StoriesState.error());
    }
  }

  Future<void> _onMark(
    _MarkSeenStoriesEvent event,
    Emitter<StoriesState> emit,
  ) async {
    if (state is! _LoadedStories) return;

    final storyId = event.id;
    final stories = (state as _LoadedStories).stories;

    // Если история уже открыта, то не нужно ее помечать
    if (stories.any((s) => s.id == storyId && s.open)) return;

    final result = await _markCase
        .call(event.id)
        .fold((failure) => throw failure, (data) => data);

    if (result) {
      // Добавить в список историй, которые были помечены прочитанными.
      seenStories.add(storyId);

      final newList = List<Story>.from(stories);

      // Пройтись по всем прочитанным историям нужно, чтобы не возникало
      // конкурентных гонок из-за асинхронных запросов.
      for (final id in seenStories) {
        final index = stories.indexWhere((s) => s.id == id);
        if (index != -1) {
          newList[index] = stories[index].copyWithOpen(true);
        }
      }

      return emit(_LoadedStories(stories: newList));
    }
  }
}
