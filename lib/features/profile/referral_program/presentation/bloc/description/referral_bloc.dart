import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_description.dart';
import 'package:niagara_app/features/profile/referral_program/domain/use_cases/get_referral_description_use_case.dart';

part 'referral_event.dart';
part 'referral_state.dart';
part 'referral_bloc.freezed.dart';

@injectable
class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  ReferralBloc(
    this._getInfo,
    this._hasAuth,
  ) : super(const _Loading()) {
    on<_StartedEvent>(_onStarted);
  }

  final GetReferralDescriptionUseCase _getInfo;
  final HasAuthStatusUseCase _hasAuth;

  Future<void> _onStarted(
    _StartedEvent event,
    Emitter<ReferralState> emit,
  ) async {
    emit(const _Loading());
    await _hasAuth().fold(
      (failure) => emit(_Error(message: failure.error)),
      (hasAuth) async {
        if (!hasAuth) return emit(const _Unauthorized());

        await _getInfo(NoParams()).fold(
          (failure) => emit(_Error(message: failure.error)),
          (info) => emit(_Loaded(statusDescription: info)),
        );
      },
    );
  }
}
