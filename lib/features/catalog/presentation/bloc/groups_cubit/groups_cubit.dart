import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/domain/use_cases/get_groups_use_case.dart';

part 'groups_cubit.freezed.dart';
part 'groups_state.dart';

@lazySingleton
class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(this._getGroupsUseCase) : super(const _Loading()) {
    /// При запуске приложения запрашиваем список групп
    getGroups();
  }

  final GetGroupsUseCase _getGroupsUseCase;

  Future<void> getGroups() async {
    emit(const _Loading());
    final result = await _getGroupsUseCase.call();
    result.fold(
      (failure) => emit(const _Error()),
      (groups) => emit(_Loaded(groups)),
    );
  }
}
