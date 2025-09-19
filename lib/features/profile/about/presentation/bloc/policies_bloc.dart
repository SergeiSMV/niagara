import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/core.dart';
import '../../../../../core/utils/enums/policy_type.dart';
import '../../domain/model/policy.dart';
import '../../domain/use_cases/get_policies_use_case.dart';

part 'policies_event.dart';
part 'policies_state.dart';
part 'policies_bloc.freezed.dart';

/// Тип для эмиттера состояния блока
typedef _Emit = Emitter<PoliciesState>;

/// Блок для работы с политикой конфиденциальности и маркетинговым
/// соглашением
@injectable
class PoliciesBloc extends Bloc<PoliciesEvent, PoliciesState> {
  PoliciesBloc(this._getPoliciesUseCase) : super(const _Loading()) {
    on<_StartedEvent>(_onStarted);
  }

  /// Usecase для получения политики конфиденциальности или маркетингового
  /// соглашения
  final GetPoliciesUseCase _getPoliciesUseCase;

  /// Обработчик события загрузки политики конфиденциальности или
  /// маркетингового соглашения
  Future<void> _onStarted(_StartedEvent event, _Emit emit) async {
    emit(const _Loading());

    await _getPoliciesUseCase.call(event.type).fold(
          (failure) => emit(_Error(message: failure.error)),
          (policy) => emit(_Loaded(policy: policy)),
        );
  }
}
