part of 'stories_bloc.dart';

@freezed
class StoriesEvent with _$StoriesEvent {
  const factory StoriesEvent.load() = _LoadStoriesEvent;
  const factory StoriesEvent.markSeen(String id) = _MarkSeenStoriesEvent;
}
