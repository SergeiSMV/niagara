import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/policy_type.dart';
import 'package:niagara_app/features/profile/about/domain/model/policy.dart';
import 'package:niagara_app/features/profile/about/domain/use_cases/get_policies_use_case.dart';

part 'policies_event.dart';
part 'policies_state.dart';
part 'policies_bloc.freezed.dart';

typedef _Emit = Emitter<PoliciesState>;

@injectable
class PoliciesBloc extends Bloc<PoliciesEvent, PoliciesState> {
  PoliciesBloc(this._getPoliciesUseCase) : super(const _Loading()) {
    on<_StartedEvent>(_onStarted);
  }

  final GetPoliciesUseCase _getPoliciesUseCase;

  Future<void> _onStarted(_StartedEvent event, _Emit emit) async {
    emit(const _Loading());

    await _getPoliciesUseCase.call(event.type).fold(
          (failure) => emit(_Error(message: failure.error)),
          (policy) => emit(_Loaded(policy: policy)),
        );
  }
}
