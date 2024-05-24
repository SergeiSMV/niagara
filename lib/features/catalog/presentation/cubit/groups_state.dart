part of 'groups_cubit.dart';

@freezed
class GroupsState with _$GroupsState {
  const factory GroupsState.loading() = _Loading;

  const factory GroupsState.loaded(List<Group> groups) = _Loaded;

  const factory GroupsState.error() = _Error;
}
