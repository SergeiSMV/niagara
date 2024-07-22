part of 'stories_bloc.dart';

@freezed
class StoriesState with _$StoriesState {
  const factory StoriesState.loading() = _LoadingStories;
  const factory StoriesState.loaded({
    required List<Story> stories,
  }) = _LoadedStories;
  const factory StoriesState.error() = _ErrorStories;
}
