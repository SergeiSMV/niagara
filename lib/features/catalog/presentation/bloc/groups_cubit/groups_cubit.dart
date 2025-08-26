import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/core.dart';
import '../../../domain/model/group.dart';
import '../../../domain/use_cases/get_groups_use_case.dart';

part 'groups_cubit.freezed.dart';
part 'groups_state.dart';

/// Блок для работы с группами товаров
@lazySingleton
class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(this._getGroupsUseCase) : super(const _Loading()) {
    /// При запуске приложения запрашиваем список групп
    // ignore: discarded_futures
    getGroups();
  }

  /// Usecase для получения списка групп товаров
  final GetGroupsUseCase _getGroupsUseCase;

  /// Получает список групп товаров
  Future<void> getGroups() async {
    emit(const _Loading());
    final result = await _getGroupsUseCase.call();
    result.fold(
      (failure) => emit(const _Error()),
      (groups) => emit(_Loaded(groups)),
    );
  }
}
